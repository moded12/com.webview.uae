import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:naat_app/AdManager.dart';
import 'package:naat_app/Model/BookPartsOnlineApi.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/pagerDetail.dart';
import 'package:naat_app/services.dart';
import 'package:naat_app/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookPartsOnline extends StatefulWidget {
 late String apiUrl;
 late String title;

  BookPartsOnline(String title,String apiUrl){
    this.title = title;
    this.apiUrl = apiUrl;
  }
  @override
  _BookPartsOnlineState createState() => _BookPartsOnlineState();
}

class _BookPartsOnlineState extends State<BookPartsOnline> {
  List <Books>booksPartsList = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      appBar: AppBar(
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(
          child: Text(widget.title,
              style: GoogleFonts.cairo(textStyle: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white
              ))),
        ),
      ),
      body: FutureBuilder(
        future: getApiResponse(widget.apiUrl),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!=null){
              var data = jsonDecode(snapshot.data.toString());
              booksPartsList = BookPartsOnlineApi
                  .fromJson(data)
                  .books;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: booksPartsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: InkWell(
                            onTap: ()  {
                              String server = booksPartsList[index].server;
                              String title = booksPartsList[index].name;
                              String total_pages = booksPartsList[index].totalPages;
                              String file_name = booksPartsList[index].fileName;
                              String ext = booksPartsList[index].ext;
                              String startPage = booksPartsList[index].startPage;
                              showAdmobFullScreenAds();
                              int currentPos =  int.parse(startPage);
                              Navigator.push(context, MaterialPageRoute(builder:(context){
                                return  MyPageViewOnline(widget.title,server,total_pages,file_name,ext,currentPos);
                              }));
                            },
                            child: Container(
                                height: 90.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AdManager.getNeumorphicBackgroundColor(),
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5.0,
                                          offset: Offset(-3, -3),
                                          color: AdManager.getNeumorphicBoxShadowColorLight()),
                                      BoxShadow(
                                          blurRadius: 5.0,
                                          offset: Offset(3, 3),
                                          color: AdManager.getNeumorphicBoxShadowColorDark()),
                                    ]),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color: AdManager.getNeumorphicBackgroundColor(),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(20.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    offset: Offset(-3, -3),
                                                    color: AdManager.getNeumorphicBoxShadowColorLight()),
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    offset: Offset(3, 3),
                                                    color: AdManager.getNeumorphicBoxShadowColorDark()),
                                              ]),
                                          child: Icon(
                                            Icons.menu_book_outlined,
                                            color: AdManager.getTextColor(),
                                            size: 30.0,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 30.0),
                                          child: Center(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle: StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      color: AdManager.getTextColor(),
                                                      fontFamily: "nunito",
                                                      fontSize: 18.0),
                                                  text: booksPartsList[index].name,
                                                ),
                                              )

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );


                      },
                    ),
                  ),
                  LoadAdmobBannerAds(),
                ],
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
