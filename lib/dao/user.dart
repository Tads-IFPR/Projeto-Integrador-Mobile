import 'package:JAJA/database/database.dart';

class UserDAO extends AppDatabase {
  User? _currentUser;

  set currentUser(User? user) {
    setChat(user!);
  }

  Future<void> setChat(User user) async {
    _currentUser = user;
  }

  User? get currentUser => _currentUser;
}

UserDAO userDAO = UserDAO();