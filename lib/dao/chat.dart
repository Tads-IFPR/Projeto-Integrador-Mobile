import 'package:drift/drift.dart';
import 'package:laboratorio/database/database.dart';

class ChatDAO extends AppDatabase {
  Chat? _currentChat;
  List<Chat> _allChats = [];
  List<Message> _messages = [];

  set currentChat(Chat? chat) {
    setChat(chat!);
  }

  Future<void> setChat(Chat chat) async {
    _currentChat = chat;
    _messages = [];
    _messages = await getMessagesForChat(chat.id);
  }

  Chat? get currentChat => _currentChat;

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

  Future<void> addMessage(String title, String text, bool isBot) async {
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
  }
}

ChatDAO chatDAO = ChatDAO();