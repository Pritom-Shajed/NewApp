import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

class ApiServices {
  final apiUrl = Uri.parse(
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=df077fdbfc1c47cd82fa177fd9d96a4d');

  Future<List<Article>> getArticle() async {
    var response = await http.get(apiUrl);

    //first of all let's check that we got a 200 statu code: this mean that the request was a succes
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      //this line will allow us to get the different articles from the json file and putting them into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
//   Future<List<Article>?> getArticle() async {
//     final uri = Uri.parse(apiUrl);

//     var response = await http.get(uri);
//     if (response.statusCode == 200) {
//       var body = response.body;
//       return articleFromJson(body);
//     } else {
//       throw 'Error Occured';
//     }
//   }
// }
