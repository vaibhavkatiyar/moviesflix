import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'serach_page.dart';
import 'package:page_transition/page_transition.dart';
import 'nav_drawer.dart';
import 'package:swipedetector/swipedetector.dart';
import 'dart:ui';
import 'movie_detail.dart';

class MoviesList extends StatefulWidget {
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  int page=1;
  String dropdownValue = 'Sort By';
  String sort='popularity.desc';
  String value;


  Future<Map> getJson() async {
    var url = 'http://api.themoviedb.org/3/discover/tv?api_key=6a7755e386468be6db6963df9ba108fd&page=$page&sort_by=$sort';
    var response = await http.get(url);

    return json.decode(response.body);
  }

  var movies;
  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor:  Colors.white,
        leading: FlatButton(
          child: Icon(
            Icons.menu,
            color: Colors.indigo,
          ),
          onPressed: (){
            Navigator.push(context,  PageTransition(type: PageTransitionType.leftToRight, child: NavDrawer()));
          },
        ),
            title: Center(
               child: Text(
                'Show Time',
              style: TextStyle(
                fontFamily: 'Arvo',
                color: Colors.indigo,
              ),
            ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,  PageTransition(type: PageTransitionType.rightToLeft, child: Movies()));
              },
              child: Icon(
                Icons.search,
                color: Colors.indigo,
              ),
            ),
          )
        ],
      ),
      body:SwipeDetector (
        onSwipeRight: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context){
            return NavDrawer();
          }));
          },
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      MovieTitle(),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: movies == null ? 0: movies.length,
                        itemBuilder: (context,i){
                          return FlatButton(
                            child: MovieCell(movies,i),
                            padding: const EdgeInsets.all(0.0),
                            color: Colors.white,
                            onPressed: (){
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) {
                                    return new MovieDetail(movies[i]);
                                  }));

                            },
                          );
                        }),
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async{
                          if(page>1){
                            page--;
                          }
                          else{
                            page=1;
                          }
                          },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text(
                          '<- Prev',
                          style: TextStyle(
                            fontFamily: 'Arvo',
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(150.0,0.0,0.0,0.0),
                      ),
                      RaisedButton(
                       onPressed: () async{
                         page++;
                       },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text(
                          'Next ->',
                          style: TextStyle(
                            fontFamily: 'Arvo',
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class MovieTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: new Text(
        'Top Rated TV Shows',
        style: new TextStyle(
            fontSize: 28.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

}


class MovieCell extends StatelessWidget {

  final movies;
  final i;

  MovieCell(this.movies,this.i);

  var image_url='https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0.0),

              child: Container(
              margin: EdgeInsets.all(16.0),
                child: Container(
              width: 70.0,
              height: 70.0,
             ),
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0),
                color: Colors.grey,
                image: new DecorationImage(
                    image: new NetworkImage(
                        image_url + movies[i]['poster_path']),
                    fit: BoxFit.cover),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: new Offset(2.0, 5.0)),
                ],
              ),

            ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
                child: Column(

                  children: <Widget>[
                    Text(
                        movies[i]['name'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                    ),
                    Text(
                      movies[i]['overview'],
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: 'Arvo',
                        color: Color(0xff8785A4),
                      ),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            )
          ],
        ),
      new Container(
      width: 300.0,
      height: 0.5,
      color: const Color(0xD2D2E1ff),
      margin: const EdgeInsets.all(16.0),
      ),
      ],
    );
  }
}

