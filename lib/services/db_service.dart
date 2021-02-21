import 'package:news_app/models/article.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DbService {
  var box;

  void initDatabase() async {
    await Hive.initFlutter();
    //Hive.registerAdapter(ArticleAdapter());
    box = await Hive.openBox<Article>('news');
  }

  void saveToDatabase(List<Article> news) async {
    news.forEach((article) => box.put('${article.url}', article));
  }

  Future<List<Article>> loadFromDatabase() async {
    List<Article> result = [];
    box.keys.forEach((key) => result.add(box.get(key)));
    return result;
  }

  void close() {
    Hive.close();
  }
}
