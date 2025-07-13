import 'package:naat_app/constans.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AdManager.dart';

class tasbeeh extends StatefulWidget {
  @override
  _tasbeehState createState() => _tasbeehState();
}

class _tasbeehState extends State<tasbeeh> {
  int _n = 0;
  @override
  initState(){

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    void add() {
      setState(() {
        _n++;
      });
      if(_n%20==0){
          showAdmobFullScreenAds();
      }
    }

    return Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      appBar: new AppBar(
          backgroundColor: AdManager.getNeumorphicBackgroundColor(),
          title: Center(
            child: new Text(
              "Tasbeeh",
            style: GoogleFonts.cairo(textStyle: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            )),),
          )),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('$_n',
                  style:
                      new TextStyle(fontSize: 80.0, color: AdManager.getTextColor(),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Times New Roman"
                      )),
              Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: MaterialButton(
                  color: AdManager.getNeumorphicBackgroundColor(),
                  elevation: 18,
                  minWidth: 200,
                  splashColor: Colors.blue,
                  highlightElevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  textColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Counter',
                      style: TextStyle(
                        fontSize: 22.0,
fontFamily: "Times New Roman"
                      ),
                    ),
                  ),
                  onPressed: () {
                    add();
                  },
                ),
              ),
              SizedBox(height: 20,),
              LoadAdmobBannerAds(),
            ],
          ),
        ),
      ),
    );
  }
}
