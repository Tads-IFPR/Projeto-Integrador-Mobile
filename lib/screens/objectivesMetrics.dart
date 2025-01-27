import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:laboratorio/database/database.dart';

import '../schemas/objectives.dart';
import 'objectives.dart';

class UserMetricsScreen extends StatefulWidget {
  const UserMetricsScreen({super.key});

  @override
  _UserMetricsScreenState createState() => _UserMetricsScreenState();
}

class _UserMetricsScreenState extends State<UserMetricsScreen> {
  late Future<List<ObjectiveChartData>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchUserMetrics();
  }

  Future<List<Chat>> fetchAllChats() async {
    final chats = await db.getAllRecords(db.chats);
    return chats;
  }

  Future<List<ObjectiveChartData>> fetchUserMetrics() async {
    final lastUser = await _getLastUser();
    if (lastUser == null) {
      return [];
    }

    final chatCount = await fetchChatCount(lastUser.id);
    final allChats = await fetchAllChats();
    final totalChats = allChats.length;

    final objectives = await db.customSelect(
      'SELECT value, description FROM objectives WHERE userId = ? AND type = ?',
      variables: [Variable.withInt(lastUser.id), Variable.withInt(ObjectiveType.chats.toInt())],
      readsFrom: {db.objectives},
    ).map((row) async {
      final value = row.read<int>('value');
      final description = row.read<String>('description');
      final categoryChatCount = await getCategoryChatCount(description);
      return ObjectiveChartData(description, chatCount, value, totalChats, categoryChatCount);
    }).get();

    return Future.wait(objectives);
  }

  Future<int> fetchChatCount(int userId) async {
    final chatCount = await db.customSelect(
      'SELECT COUNT(*) as count FROM chats WHERE user_id = ?',
      variables: [Variable.withInt(userId)],
      readsFrom: {db.chats},
    ).map((row) => row.read<int>('count')).getSingle();
    return chatCount;
  }

  Future<int> getCategoryChatCount(String categoryName) async {
    final query = db.customSelect(
      'SELECT COUNT(category_chat.id) as count '
          'FROM categories '
          'LEFT JOIN category_chat ON categories.id = category_chat.category_id '
          'WHERE categories.name = ?',
      variables: [Variable.withString(categoryName)],
      readsFrom: {db.categories, db.categoryChat},
    );

    final result = await query.map((row) => row.read<int>('count')).getSingle();
    return result;
  }

  Future<User?> _getLastUser() async {
    final users = await db.getAllRecords(db.users);
    if (users.isNotEmpty) {
      return users.last;
    }
    return null;
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
                PieChartData('Saved Chats', objective.savedChats),
                PieChartData('Objective Chats', objective.objectiveChats),
                PieChartData('Total Chats', objective.totalChats),
                PieChartData('Category Chats', objective.categoryChatCount),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddObjectiveScreen()),
                      );
                    },
                    child: Text('Add Objectives'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ObjectiveChartData {
  final String description;
  final int savedChats;
  final int objectiveChats;
  final int totalChats;
  final int categoryChatCount;

  ObjectiveChartData(this.description, this.savedChats, this.objectiveChats, this.totalChats, this.categoryChatCount);
}

class PieChartData {
  final String title;
  final int count;

  PieChartData(this.title, this.count);
}