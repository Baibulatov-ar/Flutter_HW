import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  final List<ArticleModel> news = List<ArticleModel>.empty(growable: true);

  Future<void> getNews() async {
    const String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=a0a05db4f6b3477ea50b2557b7c77e38";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((current) {
        if (current['urlToImage'] != null && current['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: current['title'],
            author: current['author'],
            description: current['description'],
            url: current['url'],
            urlToImage: current['urlToImage'],
            publishedAt: DateTime.parse(current['publishedAt']),
          );

          news.add(articleModel);
        }
      });
    }
  }
}

class CatNews {
  final List<ArticleModel> news = List<ArticleModel>.empty(growable: true);

  Future<void> getCatNews(String category) async {
    final String url =
        "https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=a0a05db4f6b3477ea50b2557b7c77e38";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((current) {
        if (current['urlToImage'] != null && current['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: current['author'],
            title: current['title'],
            description: current['description'],
            url: current['url'],
            urlToImage: current['urlToImage'],
            publishedAt: DateTime.parse(current['publishedAt']),
          );

          news.add(articleModel);
        }
      });
    }
  }
}
