import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/services/db_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Controller extends GetxController {
  List<Article> news = [];
  final ApiService _apiService = ApiService();
  final DbService _dbService = DbService();

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  static Controller get to => Get.find();

  void fetchNews() async {
    Hive.box<Article>(DbService.db_name).clear();
    List temp = await _apiService.getNews();
    _dbService.saveToDatabase(temp);
    news = _dbService.loadFromDatabase();
    update();
  }

  void loadDetails(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
    Hive.box<Article>(DbService.db_name).close();
  }
}
