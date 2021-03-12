import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/controller.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/resources/colors.dart';

class NewsPage extends StatelessWidget {
  final String _title = 'New York Times';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          title: Text(_title),
        ),
        body: GetBuilder<Controller>(
            init: Controller(),
            builder: (controller) {
              return ListView.builder(
                  itemCount: controller.news.length,
                  itemBuilder: (context, index) {
                    return _article(controller.news[index]);
                  });
            }));
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
                      style: ElevatedButton.styleFrom(primary: greyLight),
                      child: Text('Details'),
                      onPressed: () => Controller.to.loadDetails(article.url),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(_publishedDate,
                        style: TextStyle(color: Colors.grey)),
                  )
                ]))));
  }
}
