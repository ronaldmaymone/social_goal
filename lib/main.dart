import 'package:flutter/material.dart';
import 'package:social_goal/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Goal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppSplashScreen(),
    );
  }
}

