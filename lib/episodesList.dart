import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/services.dart';
import 'package:naat_app/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class episodesList extends StatefulWidget {
  late String apiUrl;
late String title;

 episodesList(String title,String apiUrl){
  this.title = title;
  this.apiUrl = apiUrl;
}
  @override
  _episodesListState createState() => _episodesListState();
}

class _episodesListState extends State<episodesList> {
  List episodes = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),
        title: Text(widget.title,
        style: GoogleFonts.cairo(textStyle: TextStyle(
          fontSize: 22.0,
          color: Colors.white
        ))),
      ),
      body: FutureBuilder(
        future: getApiResponse(widget.apiUrl),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!=null){
              var data = jsonDecode(snapshot.data.toString());
              episodes = data['channels_list'];
              return ListView.builder(
                itemCount: episodes.length,
                itemBuilder: (BuildContext context, int index) {

                  if (index ==1) {
                    return Column(children: [
                    //  showNativeBannerAd(),
                      Container(
                        padding: EdgeInsets.only(left:15.0,right: 15.0,top:5.0,bottom: 5.0),
                        child: Ink(

                          child: Card(
                            elevation: 18.0,
                            child: Container(

                              child: ListTile(
                                onTap: (){

                                },
                                contentPadding: EdgeInsets.all(15),

                                title: Padding(
                                  padding: const EdgeInsets.only(top:0.0,bottom: 8.0),
                                  child: Text(episodes[index]['title'],style: GoogleFonts.cairo(textStyle: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 16.0,
                                  )),


                                      maxLines: 2
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top:0.0,bottom: 8.0),
                                  child: Text(episodes[index]['description'],style: GoogleFonts.cairo(textStyle: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 12.0,
                                  )),

                                    maxLines: 2,
                                  ),
                                ),
                                leading:Card(
                                  elevation: 15.0,
                                  child: CachedNetworkImage(
                                    width: 80,
                                    height: 80,
                                    imageUrl: episodes[index]['img'],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image.network("https://via.placeholder.com/200x150",fit: BoxFit.cover,),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                      padding: EdgeInsets.only(left:15.0,right: 15.0,top:5.0,bottom: 5.0),
                      child: Ink(

                        child: Card(
                          elevation: 18.0,
                          child: Container(

                            child: ListTile(
                              onTap: (){

                              },
                              contentPadding: EdgeInsets.all(15),

                              title: Padding(
                                padding: const EdgeInsets.only(top:0.0,bottom: 8.0),
                                child: Text(episodes[index]['title'],style: GoogleFonts.cairo(textStyle: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 16.0,
                                )),


                                    maxLines: 2
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top:0.0,bottom: 8.0),
                                child: Text(episodes[index]['description'],style: GoogleFonts.cairo(textStyle: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 12.0,
                                )),

                                  maxLines: 2,
                                ),
                              ),
                              leading:Card(
                                elevation: 15.0,
                                child: CachedNetworkImage(
                                  width: 80,
                                  height: 80,
                                  imageUrl: episodes[index]['img'],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.network("https://via.placeholder.com/200x150",fit: BoxFit.cover,),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),


                            ),
                          ),


                        ),
                      ),
                    );
                  }

                },
              );
            }else{
              return Text("Error In Data");
            }

          }else if(snapshot.hasError){
            return Text('Error Occurd');
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
