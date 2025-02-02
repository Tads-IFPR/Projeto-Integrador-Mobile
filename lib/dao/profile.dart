import '../database/database.dart';
import 'package:JAJA/dao/chat.dart';

Future<void> deleteUserAndRelatedData(AppDatabase db) async {
  final lastUser = await _getLastUser();
  if (lastUser == null) {
    print('No user found');
    return;
  }
  final int userId = lastUser.id;

  return db.transaction(() async {
    final deletedMessages = await (db.delete(db.messages));
    if (deletedMessages == 0) {
      print('No messages found for user $userId');
    }

    final deletedObjectives = await (db.delete(db.objectives)..where((tbl) => tbl.userId.equals(userId))).go();
    if (deletedObjectives == 0) {
      print('No objectives found for user $userId');
    }

    final deletedUser = await (db.delete(db.users)..where((tbl) => tbl.id.equals(userId))).go();
    if (deletedUser == 0) {
      print('No user found with id $userId');
    }

    final deletedChats = deleteAllChats(chatDAO);
    if (deletedChats == 0) {
      print('No chats found for user $userId');
    }

    final deletedCategories = await (db.delete(db.categories));
    if (deletedCategories == 0) {
      print('No categories found for user $userId');
    }

    final deletedCategoryChat = deleteAllCategoryChat(db);
    if (deletedCategoryChat == 0) {
      print('No category chat found for user $userId');
    }
  });
}
Future<void> deleteAllCategoryChat(AppDatabase db) async {
  await db.delete(db.categoryChat).go();
}
Future<User?> _getLastUser() async {
  final users = await db.getAllRecords(db.users);
  if (users.isNotEmpty) {
    return users.last;
  }
  return null;
}

Future<void> deleteAllChats(ChatDAO chatDAO) async {
  final allChats = await chatDAO.getAllChats();
  for (final chat in allChats) {
    await chatDAO.deleteChat(chat.id);
  }
}