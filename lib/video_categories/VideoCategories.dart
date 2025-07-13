import 'dart:convert';

import 'package:naat_app/constans.dart';
import 'package:naat_app/episodesList.dart';
import 'package:naat_app/services.dart';
import 'package:naat_app/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoCategories extends StatefulWidget {
 late String title;
 late String api_url;
  VideoCategories(String title,String api_url){
    this.title=title;
    this.api_url=api_url;

  }
  @override
  _VideoCategoriesState createState() => _VideoCategoriesState();
}

class _VideoCategoriesState extends State<VideoCategories> {
  List allSeasons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),

        title: Text(widget.title,style: GoogleFonts.cairo(textStyle: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(

              future: getApiResponse(widget.api_url),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    var convertedJson = jsonDecode(snapshot.data.toString());
                    allSeasons = convertedJson['channels_list'];
                    return Container(
                      child: ListView.builder(
                        itemCount: allSeasons.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index ==1) {
                            return Column(children: [
                          //    showNativeBannerAd(),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                                child: Ink(
                                  child: Card(
                                    elevation: 18.0,
                                    child: Container(
                                      child: ListTile(
                                        onTap: () {
                                          String title = allSeasons[index]
                                          ['title'];
                                          String api_url = allSeasons[index]
                                          ['channel_id'];
                                          if(api_url.contains(".mp4")){

                                          }else{
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => episodesList(title,
                                                        api_url)));
                                          }
                                        },

                                        contentPadding: EdgeInsets.all(15),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['title'],
                                            style: GoogleFonts.cairo(textStyle: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 16.0,
                                            )),
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['description'],
                                            style: GoogleFonts.cairo(textStyle: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12.0,
                                            )),
                                            maxLines: 2,),
                                        ),
                                        leading: Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    allSeasons[index]['img'])),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            color: Color(0xFF000000),
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
                                        String title = allSeasons[index]
                                        ['title'];
                                        String api_url = allSeasons[index]
                                        ['channel_id'];
                                        if(api_url.contains(".mp4")){


                                        }else{
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => episodesList(title,
                                                      api_url)));
                                        }
                                      },

                                      contentPadding: EdgeInsets.all(15),
                                      title: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, bottom: 8.0),
                                        child: Text(
                                          allSeasons[index]['title'],
                                          style: GoogleFonts.cairo(textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 16.0,
                                          )),
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, bottom: 8.0),
                                        child: Text(
                                          allSeasons[index]['description'],
                                          style: GoogleFonts.cairo(textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 12.0,
                                          )),
                                          maxLines: 2,),
                                      ),
                                      leading: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  allSeasons[index]['img'])),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: Color(0xFF000000),
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
              }),
        ),
      ),
    );
  }
}
