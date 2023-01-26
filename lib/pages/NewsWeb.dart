import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  String url;

  NewsWebView({required this.url, super.key});

  @override
  State<NewsWebView> createState() => _NewsWebViewState(url: url);
}

class _NewsWebViewState extends State<NewsWebView> {
  String url;
  _NewsWebViewState({required this.url});
  WebViewController? webController;

  @override
  void initState() {
    webController = WebViewController();
    webController!.setJavaScriptMode(JavaScriptMode.unrestricted);
    webController!.setBackgroundColor(const Color(0x00000000));
    webController!.loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
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
            ]))),
        body: WebViewWidget(controller: webController!));
  }
}
