import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:laboratorio/database/database.dart';
import 'package:laboratorio/components/bottomNavigator.dart';

import 'objectives.dart';

class UserMetricsScreen extends StatefulWidget {
  const UserMetricsScreen({super.key});

  @override
  _UserMetricsScreenState createState() => _UserMetricsScreenState();
}

class _UserMetricsScreenState extends State<UserMetricsScreen> {
  late Future<List<ObjectiveChartData>> _dataFuture;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _dataFuture = _generateChartData();
  }

  Future<List<ObjectiveData>> _fetchAllObjectives() async {
    final lastUser = await _getLastUser();
    if (lastUser == null) {
      return [];
    }

    final objectives = await db.customSelect(
      'SELECT value, description FROM objectives WHERE userId = ?',
      variables: [Variable.withInt(lastUser.id)],
      readsFrom: {db.objectives},
    ).map((row) {
      final value = row.read<int>('value');
      final description = row.read<String>('description');
      return ObjectiveData(value, description);
    }).get();

    return objectives;
  }

  Future<Map<String, int>> _fetchChatCountsByCategory() async {
    final query = db.customSelect(
      'SELECT categories.name AS category_name, COUNT(chats.id) AS chat_count '
          'FROM categories '
          'LEFT JOIN category_chat ON categories.id = category_chat.category_id '
          'LEFT JOIN chats ON category_chat.chat_id = chats.id '
          'GROUP BY categories.name',
      readsFrom: {db.categories, db.categoryChat, db.chats},
    );

    final results = await query.map((row) {
      final name = row.read<String>('category_name');
      final count = row.read<int>('chat_count');
      return MapEntry(name, count);
    }).get();

    return Map.fromEntries(results);
  }

  Future<List<ComparisonResult>> _compareObjectivesWithCategories(List<ObjectiveData> objectives, Map<String, int> chatCounts) async {
    final results = <ComparisonResult>[];

    for (final objective in objectives) {
      bool matched = false;
      for (var category in chatCounts.entries) {
        if (objective.description.contains(category.key)) {
          results.add(ComparisonResult(objective, category.value));
          matched = true;
        }
      }
      if (!matched) {
        results.add(ComparisonResult(objective, 0));
      }
    }

    return results;
  }

  Future<List<ObjectiveChartData>> _generateChartData() async {
    final objectives = await _fetchAllObjectives();
    final chatCounts = await _fetchChatCountsByCategory();
    final comparisonResults = await _compareObjectivesWithCategories(objectives, chatCounts);

    return comparisonResults.map((result) {
      final comparisonValue = result.chatCount;
      return ObjectiveChartData(result.objective.description, result.objective.value, comparisonValue);
    }).toList();
  }

  Future<User?> _getLastUser() async {
    final users = await db.getAllRecords(db.users);
    if (users.isNotEmpty) {
      return users.last;
    }
    return null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the selected screen
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/chat');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/metrics');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Metrics'),
      ),
      body: FutureBuilder<List<ObjectiveChartData>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No objectives found'));
          }

          final objectives = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: objectives.length,
            itemBuilder: (context, index) {
              final objective = objectives[index];
              final chartData = [
                PieChartData('Objective Value', objective.objectiveValue),
                PieChartData('Chats Count', objective.comparisonValue),
              ];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    objective.description,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: SfCircularChart(
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      series: <CircularSeries>[
                        PieSeries<PieChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (data, _) => data.title,
                          yValueMapper: (data, _) => data.count,
                          dataLabelMapper: (data, _) => '${data.title}: ${data.count}',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigator(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddObjectiveScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ObjectiveData {
  final int value;
  final String description;

  ObjectiveData(this.value, this.description);
}

class ObjectiveChartData {
  final String description;
  final int objectiveValue;
  final int comparisonValue;

  ObjectiveChartData(this.description, this.objectiveValue, this.comparisonValue);
}

class ComparisonResult {
  final ObjectiveData objective;
  final int chatCount;

  ComparisonResult(this.objective, this.chatCount);
}

class PieChartData {
  final String title;
  final int count;

  PieChartData(this.title, this.count);
}