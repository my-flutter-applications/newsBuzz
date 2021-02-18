import 'dart:convert';

import 'package:news_bizz/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=us&apiKey=7598de1d66e24382ad7f6d1728cfdae5';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            desc: element['description'],
            urlToImage: element['urlToImage'],
            // publishedAt: element['publishedAt'],
            content: element['content'],
            articleUrl: element['url'],
          );
          news.add(article);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<Article> news = [];

  Future<void> getNews(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=7598de1d66e24382ad7f6d1728cfdae5';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            desc: element['description'],
            urlToImage: element['urlToImage'],
            // publishedAt: element['publishedAt'],
            content: element['content'],
            articleUrl: element['url'],
          );
          news.add(article);
        }
      });
    }
  }
}
