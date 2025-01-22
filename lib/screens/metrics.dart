import 'package:flutter/material.dart';
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

          final data = snapshot.data!;
          final users = data['Users'] as List<User>;
          final filesCount = data['Files']?.length ?? 0;

          return ListView(
            children: [
              const ListTile(
                title: Text('Users'),
              ),
              ...users.map((user) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${user.name}', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text('Email: ${user.email}', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text('Description: ${user.description}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              ListTile(
                title: const Text('Files'),
                subtitle: Text('Total files: $filesCount'),
              ),
            ],
          );
        },
      ),
    );
  }
}