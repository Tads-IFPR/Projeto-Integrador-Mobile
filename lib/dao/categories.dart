import 'package:drift/drift.dart';
import 'package:laboratorio/database/database.dart';

class CategoriesDAO extends AppDatabase {
  getAllCategories() async {
    return await getAllRecords(categories);
  }

  final DefaltCategories = [
    'HTML',
    'CSS',
    'JS',
    'Python',
    'Java',
    'PHP',
  ];

  Future<List<String>> getMostUsedSixCategories() async {
    var query = select(categories)..orderBy([
      (u) => OrderingTerm(expression: u.frequency, mode: OrderingMode.desc),
    ])..limit(6);

    var result = await query.get();
    var resultString = result.map((e) => e.name).toList();

    if (result.length < 6) {
      for (var i = 0; i < (6 - result.length); i++) {
        resultString.add(DefaltCategories[i]);
      }
    }

    return resultString;
  }
}

CategoriesDAO categoryDAO = CategoriesDAO();