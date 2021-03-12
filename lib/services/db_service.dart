import 'package:news_app/models/article.dart';
import 'package:hive/hive.dart';

class DbService {
  static const db_name = 'news';

  void saveToDatabase(List<Article> news) async {
    final _box = Hive.box<Article>(db_name);
    news.forEach((article) => _box.add(article));
  }

  List<Article> loadFromDatabase() {
    return Hive.box<Article>(db_name).values.toList();
  }
}
