import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/constants/loadingText.dart';
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 100,
                width: double.maxFinite,
                child: FutureBuilder(
                    future: _apiServices.getArticle(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        List<Article>? articles = snapshot.data;
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 12,
                                ),
                            itemCount: articles?.length ?? 0,
                            itemBuilder: (_, index) {
                              return Row(
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return NewsWebView(
                                              url: articles[index].url,
                                            );
                                          }));
                                        },
                                        child: ClipRRect(
                                          child: Image.network(
                                            articles![index].urlToImage,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        margin: EdgeInsets.only(
                                            left: 12, right: 12, top: 12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.red.shade50),
                                        child: Text(
                                            articles[index]
                                                .publishedAt
                                                .substring(0, 10),
                                            style: normalText),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      } else {
                        return Center(child: loadingText());
                      }
                    })),
              ),
              Expanded(
                child: FutureBuilder(
                    future: _apiServices.getArticle(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        List<Article>? articles = snapshot.data;
                        return Container(
                          margin: EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                              color: Colors.red.shade50),
                          child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 12,
                                  ),
                              itemCount: articles?.length ?? 0,
                              itemBuilder: (_, index) {
                                return ExpansionTile(
                                  textColor: Colors.red.shade900,
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
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.only(
                                                left: 12, right: 12, top: 12),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white),
                                            child: Text(
                                                articles[index].source.name!),
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Author: ',
                                                          style: normalText,
                                                        ),
                                                        TextSpan(
                                                            text:
                                                                articles[index]
                                                                    .author,
                                                            style: normalText),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 9),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.red),
                                                      onPressed: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) {
                                                            return NewsWebView(
                                                              url: articles[
                                                                      index]
                                                                  .url,
                                                            );
                                                          })),
                                                      child: Text(
                                                        'Click to get detailed News',
                                                        style: whiteText,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    })),
              ),
            ],
          ),
        ));
  }
}
