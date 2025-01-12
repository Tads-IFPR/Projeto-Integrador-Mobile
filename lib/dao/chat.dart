import 'package:laboratorio/database/database.dart';

class ChatDAO extends AppDatabase {
  Chat? _currentChat;
  List<Chat> allChats = [];
  List<Message> _messages = [];

  Future<List<Message>> getMessagesForChat(int chatId) {
    return (select(db.messages)..where((tbl) => tbl.chatId.equals(chatId))).get();
  }

  set currentChat(Chat? chat) {
    setChat(chat!);
  }

  Future<void> setChat(Chat chat) async {
    _currentChat = chat;
    _messages = [];
    _messages = await getMessagesForChat(chat.id);
  }

  Chat? get currentChat => _currentChat;

  Future<List<Message>> get curretChatMessagesmessages async {
    if (currentChat == null) return [];

    if (_messages.isNotEmpty) return _messages;

    _messages = await (select(db.messages)..where((tbl) => tbl.chatId.equals(currentChat!.id))).get();

    return _messages;
  }
}

ChatDAO chatDAO = ChatDAO();