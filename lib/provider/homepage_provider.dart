import 'package:assignment/data/http_service.dart';
import 'package:assignment/model/article_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class HomeProvider extends ChangeNotifier {
  List<Article> articles = [];

  HomeProvider(){
    getArticles();
  }

  void getArticles(){
    final httpService = HttpService();
    httpService.fetchTopHeadlines().then((value){
      articles = value;
    }).whenComplete(() {
      notifyListeners();
    });
  }
}
