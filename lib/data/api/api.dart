import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/models/news_models.dart';

abstract class Api {
  //https://newsapi.org/v2/everything?q=tesla&from=2026-06-12&sortBy=publishedAt&apiKey=549c78ef1ec6401883c47daf8c5acb04

  static Future<NewsModel> getNews() async {
    Uri url = Uri.https('newsapi.org', '/v2/everything', {
      'q': 'tesla',
      'from': '2026-06-16',
      'sortBy': 'publishedAt',
      'apiKey': '549c78ef1ec6401883c47daf8c5acb04',
    });
    var response = await http.get(url);
    String responseBody = response.body;

    Map<String, dynamic> json = jsonDecode(responseBody);

    return NewsModel.fromJson(json);
  }
}
