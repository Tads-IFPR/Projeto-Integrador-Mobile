import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:laboratorio/model/user.dart';
import 'package:laboratorio/model/categories.dart';
import 'package:laboratorio/model/chats.dart';
import 'package:laboratorio/model/messages.dart';
import 'package:laboratorio/model/filesdb.dart';
import 'package:laboratorio/model/category_chat.dart';
import 'package:laboratorio/model/file_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'jja.sqlite'));
    print('Database file path: ${file.path}');

    return NativeDatabase(
      file,
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}

@DriftDatabase(tables: [Users, Categories, Chats, Messages, Filesdb, CategoryChat, FileMessage])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  get database => null;
  Future<int> createUser(UsersCompanion user) async {
    return await into(users).insert(user);
  }

  // User
  Future<List<User>> getAllUsers() async {
    return await select(users).get();
  }

  Future<User?> getUserById(int id) async {
    return await (select(users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<bool> updateUser(User user) async {
    return await update(users).replace(user);
  }

  Future<int> deleteUser(int id) async {
    return await (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  }



  // Chats
  Future<List<Chat>> getAllChats() async {
    return await select(chats).get();
  }

  Future<Chat?> getChatById(int id) async {
    return await (select(chats)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> createChat(ChatsCompanion chat) async {
    return await into(chats).insert(chat);
  }

  Future<bool> updateChat(Chat chat) async {
    return await update(chats).replace(chat);
  }

  Future<int> deleteChat(int id) async {
    return await (delete(chats)..where((tbl) => tbl.id.equals(id))).go();
  }

// Messages
  Future<List<Message>> getAllMessages() async {
    return await select(messages).get();
  }

  Future<Message?> getMessageById(int id) async {
    return await (select(messages)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> createMessage(MessagesCompanion message) async {
    return await into(messages).insert(message);
  }

  Future<bool> updateMessage(Message message) async {
    return await update(messages).replace(message);
  }

  Future<int> deleteMessage(int id) async {
    return await (delete(messages)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Categories
  Future<List<Category>> getAllCategories() async {
    return await select(categories).get();
  }

  Future<Category?> getCategoryById(int id) async {
    return await (select(categories)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> createCategory(CategoriesCompanion category) async {
    return await into(categories).insert(category);
  }

  Future<bool> updateCategory(Category category) async {
    return await update(categories).replace(category);
  }

  Future<int> deleteCategory(int id) async {
    return await (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  // CategoryChat

  Future<List<CategoryChatData>> getAllCategoryChats() async {
    return await select(categoryChat).get();
  }

  Future<CategoryChatData?> getCategoryChatById(int id) async {
    return await (select(categoryChat)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> createCategoryChat(CategoryChatCompanion categoryChat) async {
    return await into(categoryChat as TableInfo<Table, dynamic>).insert(categoryChat);
  }

  Future<bool> updateCategoryChat(CategoryChatData categoryChat) async {
    return await update(categoryChat as TableInfo<Table, dynamic>).replace(categoryChat);
  }

  Future<int> deleteCategoryChat(int id) async {
    return await (delete(categoryChat)..where((tbl) => tbl.id.equals(id))).go();
  }

  // FileMessage
  Future<List<FileMessageData>> getAllFileMessages() async {
    return await select(fileMessage).get();
  }

  Future<FileMessageData?> getFileMessageById(int id) async {
    return await (select(fileMessage)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> createFileMessage(FileMessageCompanion fileMessage) async {
    return await into(fileMessage as TableInfo<Table, dynamic>).insert(fileMessage);
  }

  Future<bool> updateFileMessage(FileMessageData fileMessage) async {
    return await update(fileMessage as TableInfo<Table, dynamic>).replace(fileMessage);
  }

  Future<int> deleteFileMessage(int id) async {
    return await (delete(fileMessage)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Filesdb

  Future<void> _saveImage(XFile image) async {
    final file = FilesdbCompanion.insert(
      mimeType: 'image/jpeg', // Adjust as needed
      size: await image.length(),
      path: image.path,
      duration: const Value.absent(),
    );

    try {
      await database.into(database.filesdb).insert(file);
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<List<FilesdbData>> getAllFiles() async {
    return await select(filesdb).get();
  }

  Future<FilesdbData?> getFileById(int id) async {
    return await (select(filesdb)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> createFile(FilesdbCompanion file) async {
    return await into(filesdb as TableInfo<Table, dynamic>).insert(file);
  }

  Future<bool> updateFile(FilesdbData file) async {
    return await update(file as TableInfo<Table, dynamic>).replace(file);
  }

  Future<int> deleteFile(int id) async {
    return await (delete(filesdb)..where((tbl) => tbl.id.equals(id))).go();
  }

}

