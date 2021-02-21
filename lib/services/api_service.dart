import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';
import 'package:news_app/resources/constants.dart';

class ApiService {
  final String _baseUrl = 'api.nytimes.com';
  final String _apiKey = api_key; //  ENTER YOUR API KEY

  Future<List<Article>> getNews() async {
    Map<String, String> _parameters = {'api-key': _apiKey};
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
