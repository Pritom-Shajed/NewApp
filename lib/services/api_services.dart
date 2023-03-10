import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

class ApiServices {
  final apiUrl = Uri.parse(
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=df077fdbfc1c47cd82fa177fd9d96a4d');

  Future<List<Article>> getArticle() async {
    var response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Error Occured");
    }
  }
}
