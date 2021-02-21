import 'package:news_app/models/article.dart';
import 'package:hive/hive.dart';

class DbService {
  static const db_name = 'news';
  void saveToDatabase(List<Article> news) async {
    final box = Hive.box<Article>(db_name);
    news.forEach((article) => box.add(article));
  }

  loadFromDatabase() {
    return Hive.box<Article>(db_name);
  }

  void close() {
    Hive.close();
  }
}
