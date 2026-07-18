import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_app/core/api/result_api.dart';
import 'package:news_app/features/Home/data/models/news_models.dart';

abstract class Api {
  //https://newsapi.org/v2/everything?q=tesla&from=2026-06-12&sortBy=publishedAt&apiKey=549c78ef1ec6401883c47daf8c5acb04

  static Future<ResultApi<NewsModel?>> getNews() async {
    try {
      Uri url = Uri.https('newsapi.org', '/v2/everything', {
        'q': 'tesla',
        'from': '2026-06-16',
        'sortBy': 'publishedAt',
        'apiKey': '549c78ef1ec6401883c47daf8c5acb04',
      });
      var response = await http.get(url);
      String responseBody = response.body;

      Map<String, dynamic> json = jsonDecode(responseBody);
      var data = NewsModel.fromJson(json);
      return Success<NewsModel>(data);
    } on SocketException {
      return Error<NewsModel>("No Enternet try again");
    } catch (e) {
      return Error<NewsModel>(e.toString());
    }
  }
}
