import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:laboratorio/database/database.dart';

class DatabaseOverview extends StatefulWidget {
  const DatabaseOverview({super.key});

  @override
  _DatabaseOverviewState createState() => _DatabaseOverviewState();
}

class _DatabaseOverviewState extends State<DatabaseOverview> {
  late Future<Map<String, List<dynamic>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchAllData();
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

  Future<Map<String, int>> getChatTitleCounts() async {
    final query = db.customSelect(
      'SELECT title, COUNT(*) as count FROM chats GROUP BY title',
      readsFrom: {db.chats},
    );

    final results = await query.map((row) {
      final title = row.read<String>('title');
      final count = row.read<int>('count');
      return MapEntry(title, count);
    }).get();

    return Map.fromEntries(results);
  }

  List<PieChartData> createPieChartData(Map<String, int> titleCounts) {
    return titleCounts.entries
        .map((entry) => PieChartData(entry.key, entry.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Overview'),
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
            future: getChatTitleCounts(),
            builder: (context, titleSnapshot) {
              if (titleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (titleSnapshot.hasError) {
                return Center(child: Text('Error: ${titleSnapshot.error}'));
              }

              final titleCounts = titleSnapshot.data ?? {};
              final chartData = createPieChartData(titleCounts);

              return ListView(
                children: [
                  const SizedBox(height: 16),
                  if (chartData.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Chat Titles Distribution (Pie Chart)',
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
                            dataSource: chartData,
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
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Data Summary',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text('Total Chats'),
                    subtitle: Text('Total chats: ${titleCounts.values.fold(0, (sum, value) => sum + value)}'),
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

class PieChartData {
  final String title;
  final int count;

  PieChartData(this.title, this.count);
}
