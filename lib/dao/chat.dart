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
}

ChatDAO chatDAO = ChatDAO();