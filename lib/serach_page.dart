import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesflix/wtachlist.dart';
import 'package:swipedetector/swipedetector.dart';
import 'Movies_list.dart';
import 'dart:ui';
import 'package:page_transition/page_transition.dart';
import 'searchedtv.dart';

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  double opacity = 0.0;
  String MovieName;

  @override


  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black, BlendMode.dstATop),
              image: AssetImage('images/Netflix-Background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SwipeDetector(
            onSwipeRight: () {
                Navigator.push(context,  PageTransition(type: PageTransitionType.leftToRight, child: MoviesList()));
            },
            child: Stack(
              children: <Widget>[
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: Icon(Icons.local_movies,color: Colors.white,),
                            hintText: 'Enter Movies,TV Series...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value){
                            MovieName=value;
                          },
                        ),
                      ),
                      FlatButton(
                        color: Colors.blue,
                        onPressed: () async{
                          await Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SearchedContent(MovieName);
                          }));

                          },
                        child: Text(
                          'Search Movies',
                        ),
                      ),
                      FlatButton(
                      color: Colors.blue,
                      onPressed: () async{
                      await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Searchedtv(MovieName);
                      }));

                       },
                       child: Text(
                       'Search TV Series',
                       ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
