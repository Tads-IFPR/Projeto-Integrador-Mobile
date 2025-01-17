import 'dart:io';

import 'package:drift/drift.dart';
import 'package:laboratorio/database/database.dart';

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
      userId: const Value(1),
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

  Future<void> addMessage(String title, String text, bool isBot, {File? file = null}) async {
    if (currentChat == null) {
      await addChat(title);
    }

    var message = MessagesCompanion.insert(
      chatId: currentChat!.id,
      messageText: text,
      isBot: isBot
    );

    var id = await createRecord(db.messages, message);
    var messageModel = await db.getRecordById(db.messages, id);
    if (messageModel != null) {
      _messages.add(messageModel);
    }

    if (file != null && messageModel != null) {
      await associateFileWithMessage(file, messageModel.id);
    }
  }

  Future<int> associateFileWithMessage(File file, int messageId) async {
    FilesdbData finalFile = await saveFile(file);
    return into(fileMessage).insert(FileMessageCompanion.insert(
      messageId: messageId,
      fileId: finalFile.id,
    ));
  }

  Future<List<FilesdbData>> getFilesForMessage(int messageId) {
    return (select(db.filesdb)..where((file) => file.id.isInQuery(
      select(fileMessage)..where((fm) => fm.messageId.equals(messageId))..get()..map((fm) => fm.fileId),
    ))).get();
  }
}

ChatDAO chatDAO = ChatDAO();