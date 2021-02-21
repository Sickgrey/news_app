import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article {
  @HiveField(0)
  String title;

  @HiveField(1)
  String text;

  @HiveField(2)
  String url;

  @HiveField(3)
  String publishedDate;

  Article({this.title, this.text, this.url, this.publishedDate});

  Article.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    text = data['abstract'];
    url = data['url'];
    publishedDate = data['published_date'];
  }
}
