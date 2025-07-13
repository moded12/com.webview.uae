import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naat_app/AdManager.dart';
import 'package:naat_app/BookSection/StartScreen.dart';
import 'package:naat_app/InkWellDrawer.dart';
import 'package:naat_app/Model/BookCollection.dart';
import 'package:naat_app/ReadOffline/PageDetailOffline.dart';
import 'package:naat_app/constans.dart';
class BookParts extends StatefulWidget {
  late List<Dashboard> radiosList;


  @override
  _BookPartsState createState() => _BookPartsState();
}

class _BookPartsState extends State<BookParts> {
  bool isloaded = false;
  getData() async {
    String response = await DefaultAssetBundle.of(context).loadString(
        "assets/book_content.json");

    var data = json.decode(response);
    widget.radiosList = BookCollection
        .fromJson(data)
        .dashboard;
    isloaded = true;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
    backgroundColor: AdManager.getNeumorphicBackgroundColor(),
    drawer: InkWellDrawer(),
    appBar: AppBar(

      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      title: Center(child: Text(AdManager.appName,style: TextStyle(color: AdManager.getTextColor(),fontSize: 22.0),),),),
      body: isloaded ? loadList(widget.radiosList) : getWidgetData()  ,
      //  bottomNavigationBar: widget.isloaded ? bottomNavigationList() : null,
    );
  }
  loadList(  List<Dashboard> radiosList) {
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
                    showAdmobFullScreenAds();
                    String server = radiosList[pos].apiUrl;
                    String title = radiosList[pos].title;
                    String total_pages = radiosList[pos].count;
                    String file_name = radiosList[pos].fileName;
                    String ext = radiosList[pos].ext;


                    int currentPos =  int.parse(radiosList[pos].startPage);

                    Navigator.push(context, MaterialPageRoute(builder:(context){
                      return  MyPageViewOffline(title,server,total_pages,file_name,ext,currentPos);
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
                              const EdgeInsets.only(left: 10.0),
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
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 0.0),
                                  child: Center(
                                    child: Text(radiosList[pos].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: AdManager.getTextColor(),
                                            fontFamily: "nunito",
                                            fontSize: 20.0)),
                                  ),
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

  getWidgetData() {
    getData();
    return Center(child: CircularProgressIndicator());
  }

}
