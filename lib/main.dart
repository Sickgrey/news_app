import 'package:flutter/material.dart';
import 'package:news_app/resources/themes.dart';
import 'package:news_app/ui/news_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: mainTheme, home: NewsPage());
  }
}
