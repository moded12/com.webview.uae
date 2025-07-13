import 'dart:convert';

import 'package:naat_app/MyTabbedPage.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AdManager.dart';
import '../constans.dart';

class ReadQuran extends StatefulWidget {
  static String READ_QURAN = "";

late String title;
late String api_url;
late bool showTitle;
  ReadQuran(String title,String api_url,bool showTitle){
    this.title=title;
    this.api_url=api_url;
    this.showTitle = showTitle;
  }
  @override
  _ReadQuranState createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran> {
  List allSeasons = [];

  @override
  Widget build(BuildContext context) {
   return widget.showTitle ?  Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      appBar: AppBar(
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(child: Text(widget.title,style: GoogleFonts.cairo(textStyle: TextStyle(
          color: AdManager.getTextColor(),
          fontSize: 22.0,
        )),)),
      ),
      body: Center(
        child: Container(
          child: showData(),
        ),
      ),
    ) :  Scaffold(
    backgroundColor: AdManager.getNeumorphicBackgroundColor(),

    body: Center(
    child: Container(
    child: showData(),
    ),
    ),
    );
  }

  showData() {
    String quranreciters = ReadQuran.READ_QURAN;
    if(quranreciters!=null&&quranreciters.isNotEmpty){
      var convertedJson = jsonDecode(quranreciters);

      allSeasons = convertedJson['read_quran'];
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      String title = allSeasons[index]['name'];
                                      String Server =
                                      allSeasons[index]['Server'];
                                      String file_name =
                                      allSeasons[index]['file_name'];
                                      String count = allSeasons[index]['count'];
                                      String ext = allSeasons[index]['ext'];
                                      String surah_pages =
                                      allSeasons[index]['surah_pages'];
                                      String parahs_pages =
                                      allSeasons[index]['parahs_pages'];
                                      return TabBarDemo(
                                          title,
                                          Server,
                                          file_name,
                                          count,
                                          ext,
                                          surah_pages,
                                          parahs_pages);
                                    }));
                              },
                              contentPadding: EdgeInsets.all(15),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Text(
                                  allSeasons[index]['name'],
                                  style: GoogleFonts.cairo(textStyle: TextStyle(
                                    color: AdManager.getTextColor(),
                                    fontSize: 16.0,
                                  )),
                                ),
                              ),
                             /* subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  allSeasons[index]['name'],
                                  style: GoogleFonts.cairo(textStyle: TextStyle(
                                    color: AdManager.getTextColor(),
                                    fontSize: 12.0,
                                  )),
                                  maxLines: 2, ),
                              ),*/
                              leading: Card(
                                elevation: 18.0,
                                color: AdManager.getNeumorphicBoxShadowColorLight(),
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.ondemand_video,
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
            ),
            widget.showTitle ? LoadAdmobBannerAds(): Container(),
          ],
        ),
      );

    }else{
      return FutureBuilder(
          future: getApiResponse(widget.api_url),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                ReadQuran.READ_QURAN = snapshot.data.toString();
                var convertedJson = jsonDecode(snapshot.data.toString());
                allSeasons = convertedJson['read_quran'];
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

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) {
                                                String title = allSeasons[index]['name'];
                                                String Server =
                                                allSeasons[index]['Server'];
                                                String file_name =
                                                allSeasons[index]['file_name'];
                                                String count = allSeasons[index]['count'];
                                                String ext = allSeasons[index]['ext'];
                                                String surah_pages =
                                                allSeasons[index]['surah_pages'];
                                                String parahs_pages =
                                                allSeasons[index]['parahs_pages'];
                                                return TabBarDemo(
                                                    title,
                                                    Server,
                                                    file_name,
                                                    count,
                                                    ext,
                                                    surah_pages,
                                                    parahs_pages);
                                              }));
                                        },
                                        contentPadding: EdgeInsets.all(15),
                                        title: Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['name'],
                                            style: GoogleFonts.cairo(textStyle: TextStyle(
                                              color: AdManager.getTextColor(),
                                              fontSize: 16.0,
                                            )),
                                          ),
                                        ),
                                        /*subtitle: Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['name'],
                                            style: GoogleFonts.cairo(textStyle: TextStyle(
                                              color: AdManager.getTextColor(),
                                              fontSize: 12.0,
                                            )),
                                            maxLines: 2, ),
                                        ),*/
                                        leading: Card(
                                          elevation: 18.0,
                                          color: AdManager.getNeumorphicBoxShadowColorLight(),
                                          child: CircleAvatar(
                                            child: Icon(
                                              Icons.ondemand_video,
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
