class Article {
  String title;
  String text;
  String url;
  String publishedDate;

  Article({this.title, this.text, this.url, this.publishedDate});

  Article.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    text = data['abstract'];
    url = data['url'];
    publishedDate = data['published_date'];
  }
}
