import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';

class ApiService {
  final String _baseUrl = 'api.nytimes.com';
  static const String api_key =
      'G6t8NF8zyen7IxJkC96NJzzRbaqc5An6'; //  ENTER YOUR API KEY

  Future<List<Article>> getNews() async {
    Map<String, String> _parameters = {'api-key': api_key};
    String _unencodedPath = '/svc/topstories/v2/home.json';
    List<Article> list = [];
    try {
      var uri = Uri.http(_baseUrl, _unencodedPath, _parameters);
      var response = await http.get(uri);
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      data['results'].forEach((article) => list.add(Article.fromMap(article)));
    } catch (err) {
      print(err.toString());
    }
    return list;
  }
}
