import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:movieapi/model/movieapijson.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:movieapi/pages/search.dart';
import 'package:flip_card/flip_card.dart';

class Details extends StatefulWidget {
  Movieapi movie;
  Details({this.movie});

  @override
  _Detailstate createState() => _Detailstate();
}

class _Detailstate extends State<Details> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white12,
            body: WillPopScope(
              onWillPop: _backpress,
              child: _detailbuild(),
            ),
            bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.white30,
                items: <Widget>[
                  Icon(Icons.home, size: 30),
                  Icon(Icons.search, size: 30),
                  Icon(Icons.compare_arrows, size: 30),
                ],
                onTap: (index) {
                  if (index == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchBarDemoApp()));
                  }
                  if(index==2)
                  {
                    _backpress();
                  }
                })));
    // TODO: implement build
  }

  Future<bool> _backpress() {
    Navigator.of(context).pop(context);
  }

  Widget _detailbuild() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Divider(
            height: 10,
          ),
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.black12,
              child: FlipCard(
                key: cardKey,
                flipOnTouch: true,
                front: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: RaisedButton(
                      onPressed: () => cardKey.currentState.toggleCard(),
                      child: Flexible(
                        child: Text(widget.movie.title.toString(),
                            style: GoogleFonts.sniglet(
                              fontSize: 25,
                            )),
                        fit: FlexFit.loose,
                      )),
                ),
                back: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: RaisedButton(
                    onPressed: () => cardKey.currentState.toggleCard(),
                    child: Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          "Directed BY : " + widget.movie.director.toString(),
                          style: GoogleFonts.sniglet(
                            fontSize: 25,
                          ),
                        )),
                  ),
                ),
              )),
          Divider(
            height: 15,
          ),
          Text("Genres : " + getGeners(widget.movie.genres.toString()),
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Row(
            children: [
              Container(
                  width: SizeConfig.screenWidth / 2.5,
                  height: 250.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(widget.movie.poster.toString()),
                      ))),
              FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                            height: 250,
                            alignment: Alignment.center,
                            child: Column(children: [
                              Divider(
                                height: 20,
                              ),
                              SizedBox(
                                  child: Text(
                                      "Language : " +
                                          widget.movie.originalLanguage
                                              .toString(),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 30),
                              SizedBox(
                                  child: Text(
                                      "Rating : ⭐ " +
                                          widget.movie.voteAverage.toString(),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 30),
                              SizedBox(
                                  child: Text(
                                      "Votes : " +
                                          widget.movie.voteCount.toString(),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 30),
                              SizedBox(
                                  child: Text(
                                      "Budget : " +
                                          widget.movie.budget.toString(),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 30),
                              SizedBox(
                                  child: Text(
                                      "Gross : " +
                                          widget.movie.revenue.toString(),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 30),
                              SizedBox(
                                  child: Text(
                                      "Runtime : " +
                                          widget.movie.runtime.toString() +
                                          " min",
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 30),
                            ])))),
                back: Container(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                            height: 250,
                            alignment: Alignment.center,
                            child: Column(children: [
                              Divider(
                                height: 20,
                              ),
                              SizedBox(
                                  child: Text(
                                      "Director : " +
                                          widget.movie.director.toString(),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 50),
                              SizedBox(
                                  child: Text(
                                      "Production : " +
                                          getGeners(
                                              widget.movie.pcompany.toString()),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                  width: 150,
                                  height: 120),
                            ])))),
              ),
            ],
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Text('Details ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oxygen(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5.0),
                  DefaultTabController(
                      length: 4, // length of tabs
                      initialIndex: 0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey,
                                tabs: [
                                  Tab(text: 'Tagline'),
                                  Tab(text: 'Overview'),
                                  Tab(text: 'Cast'),
                                  Tab(text: 'Crew'),
                                ],
                              ),
                            ),
                            Container(
                                height: SizeConfig.screenHeight /
                                    2, //height of TabBarView
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.5))),
                                child: TabBarView(children: <Widget>[
                                  ListView(children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ListTile(
                                            title: Text(
                                                widget.movie.tagline.toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                                  ListView(children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ListBody(
                                            children: [
                                              Text(
                                                  widget.movie.overview
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                                  ListView(children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ListTile(
                                            title: Text(
                                                widget.movie.casts.toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                  ListView(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ListTile(
                                              title: Text(
                                                  widget.movie.crewDetails
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ]))
                          ])),
                  SizedBox(
                    height: 50,
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

getGeners(String title) {
  if (title != null) {
    print(title);
    print(title
        .split(' ')
        .sublist(
          2,
        )
        .join()
        .split(',')
        .join('|'));
    //return title.split(' ').sublist(2, 4).join().split(",").join("|");
    return title
        .split(' ')
        .sublist(
          2,
        )
        .join()
        .split(',')
        .join('|');
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
