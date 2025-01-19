import 'dart:io';

import 'package:drift/drift.dart';
import 'package:laboratorio/database/database.dart';

// Yes, i know this isn't a chat DAO, because it has a CRUD of many tables
class ChatDAO extends AppDatabase {
  Chat? _currentChat;
  List<Chat> _allChats = [];
  List<Message> _messages = [];

  set currentChat(Chat? chat) {
    setChat(chat!);
  }

  Future<void> setChat(Chat? chat) async {
    _currentChat = chat;
    _messages = [];

    if (chat?.id != null) {
      _messages = await getMessagesForChat(chat!.id);
    }
  }

  Future<void> deleteChat(int chatId) async {
    await deleteMessages(chatId);
    await deleteRecordById(chats, chatId);
    _allChats.removeWhere((element) => element.id == chatId);

    if (_currentChat?.id == chatId) {
      _currentChat = null;
      _messages = [];
    }
  }

  Chat? get currentChat => _currentChat;

  Future<void> deleteMessages(int chatID) async {
    await (delete(db.messages)..where((tbl) => tbl.chatId.equals(chatID))).go();
  }

  Future<List<Message>> getMessagesForChat(int chatId) {
    return (select(db.messages)..where((tbl) => tbl.chatId.equals(chatId))).get();
  }

  Future<List<Chat>> getAllChats() async {
    if (_allChats.isNotEmpty) return _allChats;

    _allChats = await getAllRecords(chats);

    return _allChats;
  }

  Future<List<Chat>> getAllChatsByCategories(List<Category> cateogories) async {
    final chatIds = await (select(db.categoryChat)..where((tbl) => tbl.categoryId.isIn(cateogories.map((e) => e.id).toList())))
        .map((tbl) => tbl.chatId)
        .get();

    return (select(db.chats)..where((tbl) => tbl.id.isIn(chatIds))).get();
  }

  List<Chat> get allChats {
    getAllChats();
    return _allChats;
  }

  List<Message> get chatMessages {
    getChatMessage();
    return _messages;
  }

  Future<List<Message>> getChatMessage() async {
    if (currentChat == null) return [];

    if (_messages.isNotEmpty) return _messages;

    _messages = await getMessagesForChat(currentChat!.id);

    return _messages;
  }

  Future<void> addChat(String title) async {
    var chat = ChatsCompanion.insert(
      title: title,
      userId: const Value(null),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      deletedAt: const Value(null),
    );

    var id = await createRecord(db.chats, chat);
    var chatModel = await db.getRecordById(db.chats, id);
    if (chatModel != null) {
      _allChats.add(chatModel);
      setChat(chatModel);
    }
  }

  Future<void> addMessage(String title, String text, bool isBot, bool isAudio, {File? audio, List<dynamic>? categories, List<File>? files}) async {
    if (currentChat == null) {
      await addChat(title);
    }

    var message = MessagesCompanion.insert(
      chatId: currentChat!.id,
      messageText: text,
      isBot: isBot,
      isAudio: isAudio
    );

    var id = await createRecord(db.messages, message);
    var messageModel = await db.getRecordById(db.messages, id);
    if (messageModel != null) {
      _messages.add(messageModel);
    }

    if (audio != null && messageModel != null) {
      await associateFileWithMessage(audio, messageModel.id);
    }

    if (messageModel != null && files != null) {
      for (var file in files) {
        await associateFileWithMessage(file, messageModel.id);
      }
    }

    if (categories != null && messageModel != null) {
      await associateCategoriesWitChat(categories);
    }
  }

  associateCategoriesWitChat(List<dynamic> categories) async {
    var categoryIds = [];
    for (var category in categories) {
      final query = select(db.categories)..where((tbl) => tbl.name.equals(category));

      var categoryModel = await query.getSingleOrNull();

      if (categoryModel != null) {
        categoryIds.add(categoryModel.id);
        continue;
      }

      var categoryInsert = CategoriesCompanion(name: Value(category));
      categoryIds.add(await createRecord(db.categories, categoryInsert));
    }

    for (var categoryId in categoryIds) {
      await into(db.categoryChat).insert(
        CategoryChatCompanion.insert(
          chatId: currentChat!.id,
          categoryId: categoryId
        )
      );
    }
  }

  Future<int?> associateFileWithMessage(File file, int messageId) async {
    FilesdbData? finalFile = await saveFile(file);
    if (finalFile == null) return null;

    return into(fileMessage).insert(FileMessageCompanion.insert(
      messageId: messageId,
      fileId: finalFile.id,
    ));
  }

  Future<List<FilesdbData>> getFilesForMessage(int messageId) async {
    final fileIds = await getFileIdsForMessage(messageId);
    if (fileIds.isEmpty) {
      return [];
    }
    return (select(db.filesdb)..where((file) => file.id.isIn(fileIds))).get();
  }

  Future<List<int>> getFileIdsForMessage(int messageId) async {
    final fileIds = await (select(fileMessage)
      ..where((fm) => fm.messageId.equals(messageId)))
        .map((fm) => fm.fileId)
        .get();

    return fileIds;
  }
}

ChatDAO chatDAO = ChatDAO();