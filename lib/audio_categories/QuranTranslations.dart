import 'dart:convert';

import 'package:naat_app/audioPlayer.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuranTranslations extends StatefulWidget {
  static String quran_translations = "";
  String title = "";
  String api_url = "";
  QuranTranslations(String title,String api_url){
    this.title = title;
    this.api_url = api_url;
  }
  @override
  _QuranTranslationsState createState() => _QuranTranslationsState();
}

class _QuranTranslationsState extends State<QuranTranslations> {
  List allSeasons = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Color(0xFF000000),
        title: Center(child: Text(widget.title,style: GoogleFonts.cairo(textStyle: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),)),
      ),*/
      body: Center(
        child: Container(
          child: showData(),
        ),
      ),
    );
  }
  showData(){
    String quranreciters = QuranTranslations.quran_translations;
    if(quranreciters!=null&&quranreciters.isNotEmpty){
      var convertedJson = jsonDecode(quranreciters);
      allSeasons = convertedJson['reciters'];
      return Container(
        child: ListView.builder(
          itemCount: allSeasons.length,
          itemBuilder: (BuildContext context, int index) {
            if (index ==1) {
              return Column(children: [
               // showNativeBannerAd(),
                Container(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                  child: Ink(
                    child: Card(
                      elevation: 18.0,
                      child: Container(
                        child: ListTile(
                          onTap: () {
                              showAdmobFullScreenAds();
                            /*Navigator.push(context, MaterialPageRoute(builder: (context) {
    ChewieAudioDemo();
  },));*/
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
                              style: GoogleFonts.cairo(textStyle: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16.0,
                              )),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              allSeasons[index]['rewaya'],
                              style: GoogleFonts.cairo(textStyle: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 12.0,
                              )),
                              maxLines: 2,),
                          ),
                          leading: Card(
                            elevation: 18.0,
                            color: Color(0xFF000000),
                            child: CircleAvatar(
                              child: Icon(
                                Icons.music_video,
                                color: Colors.white,
                              ),
                              backgroundColor: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],);
            }else{
              return Container(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                child: Ink(
                  child: Card(
                    elevation: 18.0,
                    child: Container(
                      child: ListTile(
                        onTap: () {
                            showAdmobFullScreenAds();
                          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
    ChewieAudioDemo();
  },));*/
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
                            style: GoogleFonts.cairo(textStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 16.0,
                            )),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            allSeasons[index]['rewaya'],
                            style: GoogleFonts.cairo(textStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 12.0,
                            )),
                            maxLines: 2,),
                        ),
                        leading: Card(
                          elevation: 18.0,
                          color: Color(0xFF000000),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.music_video,
                              color: Colors.white,
                            ),
                            backgroundColor: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

          },
        ),
      );
    }else{
      return FutureBuilder(
          future: getApiResponse(widget.api_url),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                QuranTranslations.quran_translations = snapshot.data.toString();
                var convertedJson = jsonDecode(snapshot.data.toString());
                allSeasons = convertedJson['reciters'];
                return Container(
                  child: ListView.builder(
                    itemCount: allSeasons.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index ==1) {
                        return Column(children: [
                     //     showNativeBannerAd(),
                          Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                            child: Ink(
                              child: Card(
                                elevation: 18.0,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                        showAdmobFullScreenAds();
                                      /*Navigator.push(context, MaterialPageRoute(builder: (context) {
    ChewieAudioDemo();
  },));*/
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
                                        style: GoogleFonts.cairo(textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16.0,
                                        )),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        allSeasons[index]['rewaya'],
                                        style: GoogleFonts.cairo(textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 12.0,
                                        )),
                                        maxLines: 2,),
                                    ),
                                    leading: Card(
                                      elevation: 18.0,
                                      color: Color(0xFF000000),
                                      child: CircleAvatar(
                                        child: Icon(
                                          Icons.music_video,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],);
                      }else{
                        return Container(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                          child: Ink(
                            child: Card(
                              elevation: 18.0,
                              child: Container(
                                child: ListTile(
                                  onTap: () {
                                      showAdmobFullScreenAds();
                                    /*Navigator.push(context, MaterialPageRoute(builder: (context) {
    ChewieAudioDemo();
  },));*/
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
                                      style: GoogleFonts.cairo(textStyle: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 16.0,
                                      )),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      allSeasons[index]['rewaya'],
                                      style: GoogleFonts.cairo(textStyle: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 12.0,
                                      )),
                                      maxLines: 2,),
                                  ),
                                  leading: Card(
                                    elevation: 18.0,
                                    color: Color(0xFF000000),
                                    child: CircleAvatar(
                                      child: Icon(
                                        Icons.music_video,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                    },
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
