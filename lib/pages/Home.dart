import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/NewsWeb.dart';
import 'package:news_app/services/api_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiServices _apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'News',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            TextSpan(
                text: 'APP',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ])),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Welcome to the era of news!',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _apiServices.getArticle(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      List<Article>? articles = snapshot.data;
                      return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: 12,
                              ),
                          itemCount: articles?.length ?? 0,
                          itemBuilder: (_, index) {
                            return ExpansionTile(
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'News: ',
                                      style: boldText,
                                    ),
                                    TextSpan(
                                        text: articles![index].title,
                                        style: normalText)
                                  ],
                                ),
                              ),
                              children: [
                                Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          articles[index].description,
                                          style: normalText,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, bottom: 8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                              articles[index].urlToImage),
                                        ),
                                      ),
                                      Center(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Date: ',
                                                style: normalText,
                                              ),
                                              TextSpan(
                                                  text: articles[index]
                                                      .publishedAt
                                                      .substring(0, 10),
                                                  style: normalText),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: TextButton(
                                            onPressed: () => Navigator.push(
                                                    context, MaterialPageRoute(
                                                        builder: (_) {
                                                  return NewsWebView(
                                                    url: articles[index].url,
                                                  );
                                                })),
                                            child: Text(
                                                'Click to get detailed News')),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
            ),
          ],
        ));
  }
}
