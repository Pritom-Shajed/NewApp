import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget loadingText(){
  return DefaultTextStyle(
    style: TextStyle(
      fontSize: 14,
      color: Colors.red,
      shadows: [
        Shadow(
          color: Colors.red,
        ),
      ],
    ),
    child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        FlickerAnimatedText('Loading...')
      ],
    ),
  );
}