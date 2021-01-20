import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
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

Future<List<Movieapi>> fetchkeyword(name, search) async {
  var url = "http://dhanushad.pythonanywhere.com/api/" +
      search.toString() +
      "/" +
      name.toString() +
      "/100";
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

class FullData extends StatefulWidget {
  var name;
  var search;
  FullData({this.search, this.name});

  @override
  _Detailstate createState() => _Detailstate();
}

class _Detailstate extends State<FullData> {
  List<Movieapi> keyword;
  int countk = 0;
  final moviek = fetchkeyword("super", 'names');

  @override
  void initState() {
    super.initState();
    final moviek = fetchkeyword(widget.name, widget.search);
    moviek.then((value) {
      setState(() {
        this.keyword = value;
        this.countk = keyword.length;
        print(countk);
      });
    });
  }

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

  Widget build(BuildContext context) {
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
                      return _buildody();
                    } else if (snapshot.hasError) {
                      return SpinKitWave(
                          color: Colors.blueGrey, type: SpinKitWaveType.start);
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchBarDemoApp()));
                  }
                  if (index == 2) {
                    _backpress();
                  }
                })));
    // TODO: implement build
  }

  Future<bool> _backpress() {
    Navigator.of(context).pop(context);
  }

  Widget _buildody() {
    return Padding(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: [
            Container(
                height: 50,
                child: FlipCard(
                  front: Center(
                      child: Text(
                          widget.search.toString().toUpperCase() +
                              " Based List",
                          style: GoogleFonts.oxygen(
                              fontSize: 20, color: Colors.white))),
                  back: Center(
                    child: Text(widget.name,
                        style: GoogleFonts.oxygen(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                )),
            _detaildemo(),
          ],
        ));
  }

  Widget _detaildemo() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      childAspectRatio: 0.8,
      controller: new ScrollController(keepScrollOffset: true),
      scrollDirection: Axis.vertical,
      children: List.generate(
        countk,
        (index) {
          return Card(
              child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Details(movie: keyword.elementAt(index))));
            },
            hoverColor: Colors.black87,
            child: getposterornot(index),
          ));
        },
      ),
    );
  }

  getFirstLetter(String title) {
    if (title.length > 35) {
      return title.substring(0, 35);
    } else {
      return title;
    }
  }

  Widget getposterornot(int index) {
    var rng = new Random();
    var poster = keyword.elementAt(index).poster.toString();
    if ((poster.toLowerCase().endsWith('.gif')) ||
        (poster.toLowerCase().endsWith('icon.svg')) ||
        (poster.toLowerCase().endsWith('logo.svg'))) {
      return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
          child: Container(
            color: Colors.accents[rng.nextInt(15)],
            child: Center(
              child: Text(
                keyword.elementAt(index).title.toString(),
                style: GoogleFonts.oxygen(
                  backgroundColor: Colors.transparent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ));
    } else {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
        child: FadeInImage.assetNetwork(
          placeholder: 'needed3.gif',
          image: poster,
          fit: BoxFit.fill,
        ),
      );
    }
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
