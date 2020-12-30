import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:movieapi/keywordslimit.dart';

void main() {
  runApp(new SearchBarDemoApp());
}

class SearchBarDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Search Bar Demo', home: new SearchBarDemoHome());
  }
}

class SearchBarDemoHome extends StatefulWidget {
  @override
  _SearchBarDemoHomeState createState() => new _SearchBarDemoHomeState();
}

class _SearchBarDemoHomeState extends State<SearchBarDemoHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var movie;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Movie Api'),
      backgroundColor: Colors.black12,
    );
  }

  void onSubmitted(String value) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyApp(name: value)));
  }

  _SearchBarDemoHomeState() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: Center(
        child:
            SpinKitWave(color: Colors.tealAccent, type: SpinKitWaveType.start),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            // ignore: deprecated_member_use
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            // ignore: deprecated_member_use
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              // ignore: deprecated_member_use
              title: Text('Profile'))
        ],
      ),
    );
  }

  void updatevalue(value) {
    this.movie = value;
  }
}
