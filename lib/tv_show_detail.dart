import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Tvshowdetail extends StatelessWidget {
  final movie;
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  Tvshowdetail(this.movie);

  Color mainColor = const Color(0xff3C3261);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(fit: StackFit.loose, children: [
        new Image.network(
          image_url + movie['poster_path'],
          fit: BoxFit.cover,
        ),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        new ListView(
          children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    width: 400.0,
                    height: 400.0,
                  ),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      image: new DecorationImage(
                          image: new NetworkImage(
                              image_url + movie['poster_path']),
                          fit: BoxFit.cover),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            offset: new Offset(0.0, 10.0))
                      ]),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                            movie['title'],
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontFamily: 'Arvo'),
                          )),
      Padding(
        padding: EdgeInsets.all(10.0),
      ),
      new CircularPercentIndicator(
        radius: 70.0,
        animation: true,
        animationDuration: 1200,
        lineWidth: 5.0,
        percent: movie['vote_average']/10,
        center: new Text(
          ((movie['vote_average']*10).toInt()).toString()+'%',
          style:
          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
        ),
        circularStrokeCap: CircularStrokeCap.square,
        backgroundColor: Colors.white,
        progressColor: Colors.green,
      ),
      ],
                  ),
                ),
                FlatButton(
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        width: 170.0,
                        height: 60.0,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            'Watch Trailer',
                            style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'Arvo',
                                fontSize: 20.0),
                          ),
                        ),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      ),
                    ),
                  ),
                  onPressed: () async{
                    String head=movie['title'];
                    await launch('https://www.youtube.com/results?search_query=$head+trailer');
                  },

                ),
                new Text(movie['overview'],style: new TextStyle(color: Colors.white, fontFamily: 'Arvo',fontSize: 18.0)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text('Release Date - '+movie['release_date'],style: new TextStyle(color: Colors.white, fontFamily: 'Arvo',fontSize: 15.0),),
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),

                new Row(
                  children: <Widget>[
                    FlatButton(
                      child: new Expanded(
                        child: new Container(
                          width: 150.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          child: new Text(
                            'Rate Movie',
                            style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'Arvo',
                                fontSize: 20.0),
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        ),
                      ),
                      onPressed: (){

                        final popup = BeautifulPopup(
                          context: context,
                          template: TemplateGift,
                        );
                        popup.show(
                          title: 'Rating',
                          content: RatingBar(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              Fluttertoast.showToast(
                                  msg: '$rating',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            },
                          ),
                          actions: [
                            popup.button(
                              label: 'Close',
                              onPressed: Navigator.of(context).pop,
                            ),
                          ],
                          // bool barrierDismissible = false,
                          // Widget close,
                        );
                      },
                    ),
                    new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: new Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        )
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: new Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
    ],
        )
      ]),
    );
  }
}

