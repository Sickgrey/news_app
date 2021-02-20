import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';

class ApiService {
  final String _baseUrl = 'api.nytimes.com';
  static const String api_key = ''; //  ENTER YOUR API KEY

  Future<List<Article>> getNews() async {
    Map<String, String> _parameters = {'api-key': api_key};
    String _unencodedPath = '/svc/topstories/v2/home.json';
    try {
      var uri = Uri.http(_baseUrl, _unencodedPath, _parameters);
      var response = await http.get(uri);
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      List<Article> list = [];
      data['results'].forEach((article) => list.add(Article.fromMap(article)));
      return list;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }
}
