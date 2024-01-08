import 'dart:convert';
import 'package:assignment/model/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HttpService {
  final String baseUrl = 'https://newsapi.org/v2/';
  final String apiKey = 'a017464b15324d1aa3964bf5221e9f56';

  Future<List<Article>> fetchTopHeadlines({String country = 'us'}) async {
    final response = await http.get(Uri.parse('$baseUrl/top-headlines?country=$country&apiKey=$apiKey'));
    final List<Article> result = [];

    if (response.statusCode == 200) {
      final encodedBody = jsonDecode(response.body);
      final articles = encodedBody['articles'] as List;
      for(var article in articles){
        result.add(Article.fromJson(article));
      }
    }
    return result;
  }
}
