import 'dart:convert';
 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naat_app/AdManager.dart';
import 'package:naat_app/InkWellDrawer.dart';
import 'package:naat_app/Model/BooksApiFirebase.dart';
import 'package:naat_app/books_categories/BookPartsOnline.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/pagerDetail.dart';
import 'package:naat_app/services.dart';
class OnlineBooksFirebase extends StatefulWidget {
 late List<Books> booksList;
  bool isloaded = false;
  static String MORE_BOOKS_RESPONSE = "";
  static String API_URL = AdManager.moreBooksApiUrl;
  @override
  _OnlineBooksFirebaseState createState() => _OnlineBooksFirebaseState();
}

class _OnlineBooksFirebaseState extends State<OnlineBooksFirebase> {



  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      drawer: InkWellDrawer(),
      appBar: AppBar(

        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(child: Text("More Books",style: TextStyle(color: AdManager.getTextColor(),fontSize: 22.0),),),),
      body: showData()  ,

    );
  }
  showData() {
    String quranreciters = OnlineBooksFirebase.MORE_BOOKS_RESPONSE;
    if(quranreciters!=null&&quranreciters.isNotEmpty){
      var convertedJson = jsonDecode(quranreciters);

      widget.booksList =  BooksApiFirebase
          .fromJson(convertedJson)
          .books;
       return loadList(widget.booksList);

    }else{
      return FutureBuilder(
          future: getApiResponse(OnlineBooksFirebase.API_URL),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                OnlineBooksFirebase.MORE_BOOKS_RESPONSE = snapshot.data.toString();
                var convertedJson = jsonDecode(snapshot.data.toString());
                widget.booksList =   BooksApiFirebase
                    .fromJson(convertedJson)
                    .books;
                return loadList(widget.booksList);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }
  }
  loadList(  List<Books> radiosList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
      child: Container(
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: radiosList.length,
            itemBuilder: (ctx, pos) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: InkWell(
                  onTap: ()  {

                    String server = radiosList[pos].server;
                    String title = radiosList[pos].name;
                    String total_pages = radiosList[pos].totalPages;
                    String file_name = radiosList[pos].fileName;
                    String ext = radiosList[pos].ext;
                    String hasFehrist = radiosList[pos].hasFehrist;
            if(hasFehrist!=null&&!hasFehrist.isEmpty&&hasFehrist.contains("yes")){
              int currentPos =  0;
              Navigator.push(context, MaterialPageRoute(builder:(context){
                return  BookPartsOnline(title,server);
              }));

            }else{
              int currentPos =  0;
              showAdmobFullScreenAds();

              Navigator.push(context, MaterialPageRoute(builder:(context){
                return  MyPageViewOnline(title,server,total_pages,file_name,ext,currentPos);
              }));
            }
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
                                        text: radiosList[pos].name,
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
      ),
    );
  }


}
