import 'dart:convert';

import 'package:naat_app/audioPlayer.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AdManager.dart';
import '../AdManager.dart';
import '../AdManager.dart';
import '../AdManager.dart';
import '../AdManager.dart';
import '../AdManager.dart';

class QuranReciters extends StatefulWidget {
  static String quran_reciters = "";
  String title = "";
  String api_url = "";
  bool showTitle = true;
  QuranReciters(String title,String api_url,bool showTitle){
    this.title = title;
    this.api_url = api_url;
    this.showTitle = showTitle;
  }
  @override
  _QuranRecitersState createState() => _QuranRecitersState();
}

class _QuranRecitersState extends State<QuranReciters> {
  List allSeasons = [];
  @override
  Widget build(BuildContext context) {
    return widget.showTitle ? Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      appBar: AppBar(
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(child: Text(widget.title,style: GoogleFonts.arvo(textStyle: TextStyle(
          color: AdManager.getTextColor(),
          fontSize: 22.0,
        )),)),
      ),
      body: Center(
        child: Container(
          child: showData(),
        ),
      ),
    ) : Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),

      body: Center(
        child: Container(
          child: showData(),
        ),
      ),
    );
  }
  showData(){
    String quranreciters = QuranReciters.quran_reciters;
    if(quranreciters!=null&&quranreciters.isNotEmpty){
      var convertedJson = jsonDecode(quranreciters);
      allSeasons = convertedJson['reciters'];
      return Container(
        child: ListView.builder(
          itemCount: allSeasons.length,
          itemBuilder: (BuildContext context, int index) {

            return Container(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
              child: Ink(
                child: Card(
                  color: AdManager.getNeumorphicBackgroundColor(),
                  elevation: 18.0,
                  child: Container(
                    child: ListTile(
                      onTap: () {
                        showAdmobFullScreenAds();

                        var title = allSeasons[index]['name'];
                        var Server = allSeasons[index]['Server'];
                        var count = allSeasons[index]['count'];
                        var suras = allSeasons[index]['suras'];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChewieAudioDemo(title, Server,
                                        count, suras)));
                      },
                      contentPadding: EdgeInsets.all(15),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Text(
                          allSeasons[index]['name'],
                          style: GoogleFonts.arvo(textStyle: TextStyle(
                            color: AdManager.getTextColor(),
                            fontSize: 16.0,
                          )),
                        ),
                      ),
                      /* subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            allSeasons[index]['rewaya'],
                            style: GoogleFonts.arvo(textStyle: TextStyle(
                              color: AdManager.getTextColor(),
                              fontSize: 12.0,
                            )),
                            maxLines: 2,),
                        ),*/
                      leading: Card(
                        elevation: 18.0,
                        color: AdManager.getNeumorphicBoxShadowColorLight(),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.music_video,
                            color: Colors.white,
                          ),
                          backgroundColor: AdManager.getNeumorphicBoxShadowColorLight(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );


          },
        ),
      );
    }else{
      return FutureBuilder(
          future: getApiResponse(widget.api_url),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                QuranReciters.quran_reciters = snapshot.data.toString();
                var convertedJson = jsonDecode(snapshot.data.toString());
                allSeasons = convertedJson['reciters'];
                return Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: allSeasons.length,
                          itemBuilder: (BuildContext context, int index) {

                            return Container(
                              padding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                              child: Ink(
                                child: Card(
                                  color: AdManager.getNeumorphicBackgroundColor(),
                                  elevation: 18.0,
                                  child: Container(
                                    child: ListTile(
                                      onTap: () {
                                        showAdmobFullScreenAds();

                                        var title = allSeasons[index]['name'];
                                        var Server = allSeasons[index]['Server'];
                                        var count = allSeasons[index]['count'];
                                        var suras = allSeasons[index]['suras'];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChewieAudioDemo(title, Server,
                                                        count, suras)));
                                      },
                                      contentPadding: EdgeInsets.all(15),
                                      title: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          allSeasons[index]['name'],
                                          style: GoogleFonts.arvo(textStyle: TextStyle(
                                            color: AdManager.getTextColor(),
                                            fontSize: 16.0,
                                          )),
                                        ),
                                      ),
                                      /*subtitle: Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['rewaya'],
                                            style: GoogleFonts.arvo(textStyle: TextStyle(
                                              color: AdManager.getTextColor(),
                                              fontSize: 12.0,
                                            )),
                                            maxLines: 2,),
                                        ),*/
                                      leading: Card(
                                        elevation: 18.0,
                                        color: AdManager.getNeumorphicBoxShadowColorLight(),
                                        child: CircleAvatar(
                                          child: Icon(
                                            Icons.music_video,
                                            color: AdManager.getTextColor(),
                                          ),
                                          backgroundColor: AdManager.getNeumorphicBoxShadowColorLight(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );

                          },
                        ),
                      ),
                      widget.showTitle ? LoadAdmobBannerAds(): Container(),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            } else {
              return CircularProgressIndicator();
            }
          });
    }
  }
}
