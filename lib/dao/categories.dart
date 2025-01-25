import 'package:laboratorio/database/database.dart';

class CategoriesDAO extends AppDatabase {
  getAllCategories() async {
    return await getAllRecords(categories);
  }
}

CategoriesDAO categoryDAO = CategoriesDAO();