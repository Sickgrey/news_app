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
    List<Article> _list = [];
    try {
      final _uri = Uri.https(_baseUrl, _unencodedPath, _parameters);
      final _response = await http.get(_uri);
      final Map<String, dynamic> _data =
          json.decode(utf8.decode(_response.bodyBytes));
      _data['results']
          .forEach((article) => _list.add(Article.fromMap(article)));
    } catch (err) {
      print(err.toString());
    }
    return _list;
  }
}
