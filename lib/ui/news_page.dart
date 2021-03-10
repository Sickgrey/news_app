import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/services/db_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final String _title = 'New York Times';
  ApiService _apiService = ApiService();
  DbService _database = DbService();

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  void initState() {
    _fetchNews();
    super.initState();
  }

  void _fetchNews() async {
    var news = await _apiService.getNews();
    _database.saveToDatabase(news);
  }

  @override
  Widget build(BuildContext context) {
    var _newsList = _database.loadFromDatabase();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ListView.builder(
          itemCount: _newsList.length,
          itemBuilder: (context, index) {
            return _article(_newsList.get(index) as Article);
          }),
    );
  }

  Widget _article(Article article) {
    final String _publishedDate =
        article.publishedDate.substring(0, 19).replaceAll(RegExp('T'), ' at ');

    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
        child: Card(
            shadowColor: Colors.black,
            elevation: 20.0,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(article.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(article.text, style: TextStyle(color: Colors.black)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorLight),
                      child: Text('Details'),
                      onPressed: () => _loadDetails(article.url),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(_publishedDate,
                        style: TextStyle(color: Colors.grey)),
                  )
                ]))));
  }

  void _loadDetails(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
