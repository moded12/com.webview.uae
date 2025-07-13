import 'dart:convert';

import 'package:naat_app/audioPlayer.dart';
import 'package:naat_app/audio_categories/PlayAudio.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AdManager.dart';
import '../AdManager.dart';

class AudioCategories extends StatefulWidget {
  String title = "";
  String api_url = "";
  static String homeScreenStr = "";
  AudioCategories(String title,String api_url){
    this.title = title;
    this.api_url = api_url;
  }
  @override
  _AudioCategoriesState createState() => _AudioCategoriesState();
}

class _AudioCategoriesState extends State<AudioCategories> {
  List allSeasons = [];
  showData() {
    String response = AudioCategories.homeScreenStr;
    if (response != null && response.isNotEmpty) {
      var convertedJson = jsonDecode(response);
      allSeasons = convertedJson['reciters'];

      return Center(
        child: Container(
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
                            /*Navigator.push(context, MaterialPageRoute(builder: (context) {
    ChewieAudioDemo();
  },));*/
                            var id = allSeasons[index]['id'];
                            var name = allSeasons[index]['name'];
                            var server = allSeasons[index]['server'];
                            var count = allSeasons[index]['count'];
                            var img_url = allSeasons[index]['img_url'];
                            var format = allSeasons[index]['format'];
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return PlayAudio(name, server);
                            }));

                          },
                          contentPadding: EdgeInsets.all(15),
                          title: Text(
                            allSeasons[index]['name'],
                            style: GoogleFonts.cairo(textStyle: TextStyle(
                              color: AdManager.getTextColor(),
                              fontSize: 16.0,
                            )),
                          ),
                        /*  subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              allSeasons[index]['name'],
                              style: GoogleFonts.cairo(textStyle: TextStyle(
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
      );
    } else {
      return Center(
        child: Container(
          child: FutureBuilder(
              future: getApiResponse(widget.api_url),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    AudioCategories.homeScreenStr =
                        snapshot.data.toString();
                    var convertedJson = jsonDecode(snapshot.data.toString());
                    allSeasons = convertedJson['rashid_function'];
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
                                              /*Navigator.push(context, MaterialPageRoute(builder: (context) {
    ChewieAudioDemo();
  },));*/
                                              var id = allSeasons[index]['id'];
                                              var name = allSeasons[index]['name'];
                                              var server = allSeasons[index]['server'];
                                              var count = allSeasons[index]['count'];
                                              var img_url = allSeasons[index]['img_url'];
                                              var format = allSeasons[index]['format'];
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return PlayAudio(name, server);
                                              }));

                                            },
                                            contentPadding: EdgeInsets.all(15),
                                            title: Text(
                                              allSeasons[index]['name'],
                                              style: GoogleFonts.cairo(textStyle: TextStyle(
                                                color: AdManager.getTextColor(),
                                                fontSize: 16.0,
                                              )),
                                            ),
                                          /*  subtitle: Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Text(
                                                allSeasons[index]['name'],
                                                style: GoogleFonts.cairo(textStyle: TextStyle(
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
                          LoadAdmobBannerAds(),
                        ],
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
       appBar: AppBar(
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(
          child: Text(widget.title,style: GoogleFonts.cairo(textStyle: TextStyle(
            color: AdManager.getTextColor(),
            fontSize: 22.0,
          )),),
        ),
      ),
      body: showData(),
    );
  }
}


