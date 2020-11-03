import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Movies_list.dart';
import 'package:splashscreen/splashscreen.dart';
void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner:false,
      home: new MyApp(),
  ));;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 4,
        imageBackground: AssetImage('images/Netflix-Background.jpg'),
        navigateAfterSeconds: new MoviesList(),
        title: new Text('Show \n Time',
        style: TextStyle(
          color: Colors.red,
          fontFamily: 'Arvo',
          fontSize: 75,
        ),
        textAlign: TextAlign.center,),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        loaderColor: Colors.blue,

    );

  }
}

