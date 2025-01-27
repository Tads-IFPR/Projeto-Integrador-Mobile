import 'package:flutter/material.dart';
import 'package:laboratorio/screens/objectivesMetrics.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:laboratorio/database/database.dart';
import 'package:laboratorio/screens/objectives.dart';

class DatabaseOverview extends StatefulWidget {
  const DatabaseOverview({super.key});

  @override
  _DatabaseOverviewState createState() => _DatabaseOverviewState();
}

class _DatabaseOverviewState extends State<DatabaseOverview> with WidgetsBindingObserver {
  late Future<Map<String, List<dynamic>>> _dataFuture;
  late Future<User?> _lastUserFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _dataFuture = fetchAllData();
    _lastUserFuture = _getLastUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Map<String, List<dynamic>>> fetchAllData() async {
    final users = await db.getAllRecords(db.users);
    final files = await db.getAllRecords(db.filesdb);
    final categories = await db.getAllRecords(db.categories);
    final chats = await db.getAllRecords(db.chats);
    final messages = await db.getAllRecords(db.messages);
    final categoryChats = await db.getAllRecords(db.categoryChat);
    final fileMessages = await db.getAllRecords(db.fileMessage);

    return {
      'Users': users,
      'Files': files,
      'Categories': categories,
      'Chats': chats,
      'Messages': messages,
      'CategoryChats': categoryChats,
      'FileMessages': fileMessages,
    };
  }

  Future<User?> _getLastUser() async {
    final users = await db.getAllRecords(db.users);
    if (users.isNotEmpty) {
      return users.last;
    }
    return null;
  }

  Future<Map<String, int>> getCategoryChatCounts() async {
    final query = db.customSelect(
      'SELECT categories.name, COUNT(category_chat.id) as count '
          'FROM categories '
          'LEFT JOIN category_chat ON categories.id = category_chat.category_id '
          'GROUP BY categories.name',
      readsFrom: {db.categories, db.categoryChat},
    );

    final results = await query.map((row) {
      final name = row.read<String>('name');
      final count = row.read<int>('count');
      return MapEntry(name, count);
    }).get();

    return Map.fromEntries(results);
  }

  Future<Map<String, int>> getMessageCountsByCategory() async {
    final query = db.customSelect(
      'SELECT categories.name, COUNT(messages.id) as count '
          'FROM categories '
          'LEFT JOIN category_chat ON categories.id = category_chat.category_id '
          'LEFT JOIN chats ON category_chat.chat_id = chats.id '
          'LEFT JOIN messages ON chats.id = messages.chat_id '
          'GROUP BY categories.name',
      readsFrom: {db.categories, db.categoryChat, db.chats, db.messages},
    );

    final results = await query.map((row) {
      final name = row.read<String>('name');
      final count = row.read<int>('count');
      return MapEntry(name, count);
    }).get();

    return Map.fromEntries(results);
  }

  List<PieChartData> createPieChartData(Map<String, int> counts) {
    return counts.entries
        .map((entry) => PieChartData(entry.key, entry.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infos about this app'),
      ),
      body: FutureBuilder<Map<String, List<dynamic>>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          return FutureBuilder<Map<String, int>>(
            future: getCategoryChatCounts(),
            builder: (context, categorySnapshot) {
              if (categorySnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (categorySnapshot.hasError) {
                return Center(child: Text('Error: ${categorySnapshot.error}'));
              }

              final categoryCounts = categorySnapshot.data ?? {};
              final categoryChartData = createPieChartData(categoryCounts);

              return FutureBuilder<Map<String, int>>(
                future: getMessageCountsByCategory(),
                builder: (context, messageSnapshot) {
                  if (messageSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (messageSnapshot.hasError) {
                    return Center(child: Text('Error: ${messageSnapshot.error}'));
                  }

                  final messageCounts = messageSnapshot.data ?? {};
                  final messageChartData = createPieChartData(messageCounts);

                  return ListView(
                    children: [
                      FutureBuilder<User?>(
                        future: _lastUserFuture,
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (userSnapshot.hasError) {
                            return Center(child: Text('Error: ${userSnapshot.error}'));
                          }

                          final user = userSnapshot.data;
                          if (user != null) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: ${user.name}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
                                  Text('Description: ${user.description}', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No user found', style: TextStyle(fontSize: 16)),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      if (categoryChartData.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Category Chat Distribution',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
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
                                dataSource: categoryChartData,
                                xValueMapper: (data, _) => data.title,
                                yValueMapper: (data, _) => data.count,
                                dataLabelMapper: (data, _) =>
                                '${data.title}: ${data.count}',
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  labelPosition: ChartDataLabelPosition.outside,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const Divider(),
                      if (messageChartData.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Message Counts by Category',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
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
                                dataSource: messageChartData,
                                xValueMapper: (data, _) => data.title,
                                yValueMapper: (data, _) => data.count,
                                dataLabelMapper: (data, _) =>
                                '${data.title}: ${data.count}',
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  labelPosition: ChartDataLabelPosition.outside,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserMetricsScreen()),
                          );
                        },
                        child: Text('Go to Objectives'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class PieChartData {
  final String title;
  final int count;

  PieChartData(this.title, this.count);
}