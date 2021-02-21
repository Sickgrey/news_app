import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/resources/themes.dart';
import 'package:news_app/services/db_service.dart';
import 'package:news_app/ui/news_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/article.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>(DbService.db_name);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: mainTheme, home: NewsPage());
  }
}
