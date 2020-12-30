import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapi/keywordslimit.dart';

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
  SearchBar searchBar;
  final recent = new List();
  var emoji = ["🔍", '🕵', '🕶️', '👁️', '🎥', '🎬', '🍿', '🎞️'];
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    recent.add("Recent searches");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        backgroundColor: Colors.grey,
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => this.recent.add(value));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyApp(name: value)));
  }

  _SearchBarDemoHomeState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        controller: myController,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: searchBar.build(context),
        key: _scaffoldKey,
        body: recentsearch());
  }

  Widget recentsearch() {
    SizeConfig().init(context);
    final emo = (emoji.toList()..shuffle()).first;
    return this.recent.length > 1
        ? ListView.builder(
            itemCount: recent.length,
            itemBuilder: (BuildContext context, int index) {
              final item = recent.elementAt(index);
              final emo = (emoji.toList()..shuffle()).first;
              return Dismissible(
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                  key: Key(item),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      recent.removeAt(index);
                    });

                    // Then show a snackbar.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$item dismissed")));
                  },
                  // Show a red background as the item is swiped away.
                  background: Container(color: Colors.white38),
                  child: SizedBox(
                      width: SizeConfig.safeBlockHorizontal * 100,
                      height: 75.0,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyApp(name: item)));
                          },
                          child: new Card(
                            color: Theme.of(context).cardColor,

                            //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10.0),
                                  top: Radius.circular(2.0)),
                            ),
                            child: Text(
                              "$emo   $item",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'sans-serif',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))));
            },
          )
        : Center(
            child: RichText(
                text: TextSpan(
            text: 'Search for your Choice...$emo',
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'sans-serif'),
          )));
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
