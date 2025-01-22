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
          final lastUser = users.isNotEmpty ? users.last : null;
          final filesCount = data['Files']?.length ?? 0;
          final categoriesCount = data['Categories']?.length ?? 0;
          final chatsCount = data['Chats']?.length ?? 0;
          final messagesCount = data['Messages']?.length ?? 0;
          final categoryChatsCount = data['CategoryChats']?.length ?? 0;
          final fileMessagesCount = data['FileMessages']?.length ?? 0;

          return FutureBuilder<Map<String, int>>(
            future: getChatTitleCounts(),
            builder: (context, titleSnapshot) {
              if (titleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (titleSnapshot.hasError) {
                return Center(child: Text('Error: ${titleSnapshot.error}'));
              }

              final titleCounts = titleSnapshot.data ?? {};

              return ListView(
                children: [
                  if (lastUser != null)
                    ListTile(
                      title: Text('Name: ${lastUser.name}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${lastUser.email}'),
                          Text('Description: ${lastUser.description}'),
                        ],
                      ),
                    ),
                  ListTile(
                    title: const Text('Files'),
                    subtitle: Text('Total files: $filesCount'),
                  ),
                  ListTile(
                    title: const Text('Categories'),
                    subtitle: Text('Total categories: $categoriesCount'),
                  ),
                  ListTile(
                    title: const Text('Chats'),
                    subtitle: Text('Total chats: $chatsCount'),
                  ),
                  ListTile(
                    title: const Text('Messages'),
                    subtitle: Text('Total messages: $messagesCount'),
                  ),
                  ListTile(
                    title: const Text('Category Chats'),
                    subtitle: Text('Total category chats: $categoryChatsCount'),
                  ),
                  ListTile(
                    title: const Text('File Messages'),
                    subtitle: Text('Total file messages: $fileMessagesCount'),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Chat Titles Count'),
                  ),
                  if (titleCounts.isEmpty)
                    const ListTile(
                      title: Text('No chat titles found'),
                    )
                  else
                    for (var entry in titleCounts.entries)
                      ListTile(
                        title: Text(entry.key),
                        trailing: Text(entry.value.toString()),
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