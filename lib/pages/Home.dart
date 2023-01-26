import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/models/article_model.dart';
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('News', style: TextStyle(color: Colors.black)),
              Text(
                'App',
                style: (TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
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
                      return Card(
                        child: Column(
                          children: [Text(articles![index].title)],
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            })));
  }
}
