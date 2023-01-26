import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  exitDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Are you sure to exit?'),
            actions: [
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }

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
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ])),
        ),
        body: WillPopScope(
          onWillPop: () async {
            return exitDialog();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Welcome to the era of news!',
                  style: TextStyle(
                    color: Colors.red,
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
                                title: Text(articles![index].title),
                                children: [
                                  Card(
                                    color: Colors.red,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                                articles[index].urlToImage),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            articles[index].description,
                                            style: whiteText,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.all(8),
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'News Date: ',
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 9),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.red),
                                                    onPressed: () =>
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return NewsWebView(
                                                            url: articles[index]
                                                                .url,
                                                          );
                                                        })),
                                                    child: Text(
                                                        'Click to get detailed News')),
                                              ),
                                            ],
                                          ),
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
          ),
        ));
  }
}
