import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){
        return Home();
      }), (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'News',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              TextSpan(
                  text: 'APP',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            ])),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 100,
            child: LinearProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.red.shade100,
            ),
          )
        ],
      ),
    );
  }
}
