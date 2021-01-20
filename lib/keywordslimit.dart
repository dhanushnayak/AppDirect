import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:movieapi/model/movieapijson.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:movieapi/pages/search.dart';
import 'package:movieapi/pages/Details.dart';
import 'package:movieapi/pages/Fulllist.dart';

Future<List<Movieapi>> fetchkeyword(name) async {
  var url = "http://dhanushad.pythonanywhere.com/api/keywords/" + name + "/10";
  print(url);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("Wordked");
    List jsonResponse = json.decode(response.body);

    var ns = jsonResponse.map((e) => Movieapi.fromJson(e)).toList();
    return ns;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Movieapi>> fetchnames(name) async {
  var url = "http://dhanushad.pythonanywhere.com/api/names/" + name + "/10";
  print(url);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("Wordked");
    List jsonResponse = json.decode(response.body);

    var ns = jsonResponse.map((e) => Movieapi.fromJson(e)).toList();
    return ns;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Movieapi>> fetchcontent(name) async {
  var url = "http://dhanushad.pythonanywhere.com/api/content/" + name + "/10";
  print(url);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("Wordked");
    List jsonResponse = json.decode(response.body);

    var ns = jsonResponse.map((e) => Movieapi.fromJson(e)).toList();
    return ns;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Movieapi>> fetchAlbum(name) async {
  var url = "http://dhanushad.pythonanywhere.com/api/keywords/" + name + "/10";
  print(url);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("Wordked");
    List jsonResponse = json.decode(response.body);

    var ns = jsonResponse.map((e) => Movieapi.fromJson(e)).toList();
    return ns;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  var name;

  MyApp({this.name});

  @override
  _MyAppState createState() {
    // TODO: implement createState
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Movieapi> keyword;
  List<Movieapi> content;
  List<Movieapi> samename;
  int countk = 0;
  int countc = 0;
  int countsm = 0;

  bool status;
  final moviek = fetchkeyword("super");
  final moviec = fetchcontent("super");
  final moviesm = fetchnames("super");
  @override
  void initState() {
    super.initState();
    final moviek = fetchkeyword(widget.name);
    final moviec = fetchcontent(widget.name);
    final moviesm = fetchnames(widget.name);
    moviek.then((value) {
      setState(() {
        this.keyword = value;
        this.countk = keyword.length;
      });
    });
    moviec.then((value) {
      setState(() {
        this.content = value;
        this.countc = content.length;
      });
      moviesm.then((value) {
        setState(() {
          this.samename = value;
          this.countsm = samename.length;
        });
      });
    });
  }

  void onSubmitted(String value) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyApp(name: value)));
  }

  // ignore: unused_element
  _onCustomAnimationAlertPressed(context) {
    Alert(
      context: context,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      alertAnimation: FadeAlertAnimation,
    ).show();
  }

  Widget FadeAlertAnimation(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

// Alert with single button.
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => _onCustomAnimationAlertPressed(context),
          width: 120,
        )
      ],
    ).show();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  Future<bool> _backpress() {
    Navigator.of(context).pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white12,
        body: WillPopScope(
          child: Center(
            child: FutureBuilder<List<Movieapi>>(
              future: this.moviek,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildChild();
                } else if (snapshot.hasError) {
                  return _onAlertButtonPressed(context);
                }

                // By default, show a loading spinner.
                return SpinKitWave(
                    color: Colors.blueGrey, type: SpinKitWaveType.start);
              },
            ),
          ),
          onWillPop: _backpress,
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchBarDemoApp()));
            }
            if (index == 2) {
              _backpress();
            }
          },
        ),
      ),
    );
  }

  Widget _buildChild() {
    var greet = greeting();
    return Padding(
      padding: EdgeInsets.all(1),
      child: ListView(
        children: <Widget>[
          Divider(
            height: 50,
          ),
          SizedBox(
            height: 45,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white30,
                child: Text(
                  " Good $greet",
                  style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
            height: 20,
            child: Center(
                child: Text(
              "Content related to search " + widget.name,
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'sans-serif', fontSize: 15),
            )),
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
              height: 30,
              width: SizeConfig.safeBlockHorizontal * 100,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullData(
                              name: widget.name,
                              search: "names",
                            )));
                  },
                  child: Row(children: [
                    Text(
                      "   Search Related ",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mada(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white30,
                      ),
                    )
                  ]))),
          SizedBox(
            height: 310, // constrain height
            child: getsimiliarname(),
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
              height: 30,
              width: SizeConfig.safeBlockHorizontal * 100,
              child: InkWell(
                  onLongPress: () {
                    Tooltip(
                      message: "Keywords",
                      child: Text(
                        "View More Results",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullData(
                              name: widget.name,
                              search: "keywords",
                            )));
                  },
                  child: Row(children: [
                    Text(
                      "   Keyword Based ",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mada(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white30,
                      ),
                    )
                  ]))),
          SizedBox(
            height: 310, // constrain height
            child: getkeyword(),
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
              height: 30,
              width: SizeConfig.safeBlockHorizontal * 100,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullData(
                              name: widget.name,
                              search: "content",
                            )));
                  },
                  child: Row(children: [
                    Text(
                      "   Content Based ",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mada(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white30,
                      ),
                    )
                  ]))),
          SizedBox(
            height: 310, // constrain height
            child: getcontent(),
          )
        ],
      ),
    );
  }

  ListView getsimiliarname() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.countsm,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Column(
            children: [
              Container(
                  width: 150,
                  height: 300,
                  padding: new EdgeInsets.all(3.0),
                  child: new InkWell(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white10,
                        child: new Column(
                          children: [
                            new Container(
                                width: 150.0,
                                height: 180.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(this
                                          .samename
                                          .elementAt(index)
                                          .poster
                                          .toString()),
                                    ))),
                            Divider(
                              height: 10,
                            ),
                            new Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "⭐  " +
                                      samename
                                          .elementAt(index)
                                          .voteAverage
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.lato(
                                      color: Colors.white, fontSize: 15)),
                            ),
                            Divider(
                              height: 10,
                            ),
                            new Container(
                                child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: new Text(
                                        getFirstLetter(samename
                                            .elementAt(index)
                                            .title
                                            .toString()),
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.actor(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: .8))))
                              ],
                            ))
                          ],
                        )),
                    onTap: () {
                      print(samename.elementAt(index));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Details(movie: samename.elementAt(index))));
                    },
                  )),
            ],
          );
        });
  }

  ListView getkeyword() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.countk,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Column(
            children: [
              Container(
                width: 150,
                height: 300,
                padding: new EdgeInsets.all(3.0),
                child: InkWell(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white10,
                      child: new Column(
                        children: [
                          new Container(
                              width: 150.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(this
                                        .keyword
                                        .elementAt(index)
                                        .poster
                                        .toString()),
                                  ))),
                          Divider(
                            height: 10,
                          ),
                          new Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "⭐  " +
                                    keyword
                                        .elementAt(index)
                                        .voteAverage
                                        .toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 15)),
                          ),
                          Divider(
                            height: 10,
                          ),
                          new Container(
                              child: Row(
                            children: <Widget>[
                              Flexible(
                                  child: new Text(
                                      getFirstLetter(keyword
                                          .elementAt(index)
                                          .title
                                          .toString()),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.actor(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .8))))
                            ],
                          ))
                        ],
                      )),
                  onTap: () {
                    print(keyword.elementAt(index));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Details(movie: keyword.elementAt(index))));
                  },
                ),
              ),
            ],
          );
        });
  }

  getFirstLetter(String title) {
    if (title.length > 35) {
      return title.substring(0, 35);
    } else {
      return title;
    }
  }

  ListView getcontent() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.countc,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Column(
            children: [
              Container(
                width: 150,
                height: 300,
                padding: new EdgeInsets.all(3.0),
                child: InkWell(
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white10,
                      child: new Column(
                        children: [
                          new Container(
                              width: 150.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(this
                                        .content
                                        .elementAt(index)
                                        .poster
                                        .toString()),
                                  ))),
                          Divider(
                            height: 10,
                          ),
                          new Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "⭐  " +
                                    content
                                        .elementAt(index)
                                        .voteAverage
                                        .toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 15)),
                          ),
                          Divider(
                            height: 10,
                          ),
                          new Container(
                              child: Row(
                            children: <Widget>[
                              Flexible(
                                  child: new Text(
                                      getFirstLetter(content
                                          .elementAt(index)
                                          .title
                                          .toString()),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.actor(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .8))))
                            ],
                          ))
                        ],
                      )),
                  onTap: () {
                    print(content.elementAt(index));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Details(movie: content.elementAt(index))));
                  },
                ),
              ),
            ],
          );
        });
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
