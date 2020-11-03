import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moviesflix/Movies_list.dart';
import 'tv_show.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Show Time',
              style: TextStyle(fontFamily: 'Arvo',color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/Netflix-Background.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.local_movies),
            title: Text('TV Series'),
            onTap: () async {
            await Navigator.push(
            context, MaterialPageRoute(builder: (context) {
            return MoviesList();
            }));
            },
          ),
          ListTile(
            leading: Icon(Icons.local_movies),
            title: Text('Movies'),
            onTap: () async{
              await Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                return Tvshow();
              }));

            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () {
              final popup = BeautifulPopup(
              context: context,
              template: TemplateGift,
              );
              popup.show(
             title: 'Rate This App',
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
    msg: '$rating'+' \n Thank you for yor time',
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
           ListTile(
             leading: Icon(Icons.stars),
             title: Text('Watchlist'),
             onTap: (){

             },
           ),
           ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
            onTap: (){
                exit(0);
            },

          ),
        ],
      ),
    );
  }
}
