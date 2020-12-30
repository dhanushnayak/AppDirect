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
Future<List<Movieapi>> fetchkeyword(name) async {
  var url = "http://dhanushad.pythonanywhere.com/api/keywords/" + name + "/100";
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
  FullData({this.name});

  @override
  _Detailstate createState() => _Detailstate();
}
class _Detailstate extends State<FullData> {
  List<Movieapi> keyword;
  int countk=0;
  final moviek = fetchkeyword("super");
  
  @override
  void initState() { 
    super.initState();
    final moviek = fetchkeyword(widget.name);
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
  Widget _buildody()
  {
    return Padding(
      padding: EdgeInsets.all(5),
      child: 
        
          _detaildemo()
        );
  }
  Widget _detaildemo()
  {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: (itemWidth / itemHeight),
          controller: new ScrollController(keepScrollOffset: true),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          
          children: List.generate(countk, (index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: (){
                    
                  },
                  child:Container(
                  height: 500,
                  child:Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(this.keyword.elementAt(index).poster.toString()),
                      fit: BoxFit.cover,
                    ),
                    

                    borderRadius: 
                    BorderRadius.all(Radius.circular(20.0),),
                  ),
                ),
                
                
                )));
            },),
        );
      
  }
 Widget _detailbuild() {
   final orientation = MediaQuery.of(context).orientation;
   return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemCount: this.countk,
      
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GridTile(child:Container(
          width: 200,
          height: 400,
          ));
       
      },
  );

  
}



  getFirstLetter(String title) {
    if (title.length > 35) {
      return title.substring(0, 35);
    } else {
      return title;
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


