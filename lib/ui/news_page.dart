import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final String title = 'New York Times';
  ApiService apiService = ApiService();
  List<Article> _news = [];

  @override
  void initState() {
    _fetchNews();
    super.initState();
  }

  _fetchNews() async {
    var news = await apiService.getNews();
    setState(() {
      _news = news;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: _news.length,
          itemBuilder: (context, index) {
            return _article(_news[index]);
          }),
    );
  }

  _article(Article article) {
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
                    child: RaisedButton(
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

  _loadDetails(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
