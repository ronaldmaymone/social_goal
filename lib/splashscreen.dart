import 'package:flutter/material.dart';
import 'package:social_goal/pages/rootpage.dart';
import 'auth.dart';
import 'package:splashscreen/splashscreen.dart';

class AppSplashScreen extends StatefulWidget{
  @override
  State createState() {
    return new _AppSplashScreenState();
  }
}

class _AppSplashScreenState extends State<AppSplashScreen>{

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: RootPage(auth: Auth(),),
      title: Text("Social Goal",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.amber),),

    );
  }
}