import 'package:drift/drift.dart';
import 'package:laboratorio/database/database.dart';

Future<void> deleteUserAndRelatedData(AppDatabase db) async {
  const int userId = 1;
  return db.transaction(() async {
    // Delete messages related to the user
    final deletedMessages = await db.deleteRecordById(db.messages, userId);
    if (deletedMessages == 0) {
      print('No messages found for user $userId');
    }



    // Delete the user
    final deletedUser = await db.deleteRecordById(db.users, userId);
    if (deletedUser == 0) {
      print('No user found with id $userId');
    }
  });
}