import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:launch_review/launch_review.dart';
import 'package:naat_app/Model/AllApps.dart';
import 'package:naat_app/Model/RecordsModel.dart';
import 'package:naat_app/MultipleGridView.dart';
import 'package:naat_app/WebViewExample.dart';
import 'package:naat_app/apiConstants.dart';
import 'package:naat_app/audio_categories/AudioCategories.dart';
import 'package:naat_app/audio_categories/QuranReciters.dart';
import 'package:naat_app/books_categories/OpenPdfExternal.dart';
import 'package:naat_app/books_categories/WebViewPage.dart';
import 'package:naat_app/books_categories/web_view_screen.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/main.dart';
import 'package:naat_app/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AdManager.dart';
import '../AdManager.dart';
import '../constans.dart';
import '../tasbeeh.dart';
import 'ReadQuran.dart';

class BooksCategories extends StatefulWidget {
 late String title;
 late String api_url;
  static String BOOK_CATEGORIES = "";

  BooksCategories(String title, String api_url) {
    this.title = title;
    this.api_url = api_url;
  }

  @override
  _BooksCategoriesState createState() => _BooksCategoriesState();
}

class _BooksCategoriesState extends State<BooksCategories> {
  List<AppsList> allSeasons = [];

  @override
  Widget build(BuildContext context) {
    return widget.title.isEmpty
        ? showData()
        : Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AdManager.getTextColor()),
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(
            child: Text(
              widget.title,
              style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      ),
      body: showData(),
    );
  }
  showDataOffline(String apiUrl){
    if(apiUrl!=null&&apiUrl.isNotEmpty){
      String? body =  box.get(apiUrl);
      if(body!=null&&body.isNotEmpty){
        allSeasons =
            AllApps.fromJson(jsonDecode(body)).appsList;
        String hasCategory = allSeasons[0].hasCategory;

        String title = allSeasons[0].name;
        if (hasCategory.isEmpty || hasCategory == "no") {
          String link = allSeasons[0].fileName;
          String server = allSeasons[0].server;
          if(link!=null&&link.isNotEmpty&&link=="link"){
            return WebViewApp(server);
          }else if(link!=null&&link.isNotEmpty&&link=="link_external"){
            return OpenPdfExternal(title,server);
          }else{
            return WebViewScreen(title, allSeasons);
          }
        } else {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: allSeasons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            top: 5.0,
                            bottom: 5.0),
                        child: Ink(
                          child: Card(
                            color: AdManager
                                .getNeumorphicBackgroundColor(),
                            elevation: 18.0,
                            child: new Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListTile(
                                onTap: () {
                                  showAds++;
                                  if (showAds % 3 == 0) {
                                    showAdmobFullScreenAds();
                                  }else{
                                    showAdmobFullScreenAds();
                                  }
                                  goTo(hasCategory,context,index);

                                },
                                contentPadding: EdgeInsets.all(15),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0),
                                  child: Text(
                                    allSeasons[index].name,
                                    style: GoogleFonts.cairo(
                                        textStyle: TextStyle(
                                          color: AdManager.getTextColor(),
                                          fontSize: 16.0,
                                        )),
                                    maxLines: 2,
                                  ),
                                ),

                                leading: allSeasons[index].img.isNotEmpty ? Image.network(allSeasons[index].img,width: 40,height: 40,) : Icon(
                                  Icons.menu_book_sharp,
                                  color: Colors.white,
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
        }
      }else{
        return CircularProgressIndicator();
      }
      }else{
      return CircularProgressIndicator();
    }
  }
  showData() {
    return Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: getApiResponse(widget.api_url),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    allSeasons =
                        AllApps.fromJson(jsonDecode(snapshot.data)).appsList;
                    String hasCategory = allSeasons[0].hasCategory;

                    String title = allSeasons[0].name;
                    if (hasCategory.isEmpty || hasCategory == "no") {
                      String link = allSeasons[0].fileName;
                      String server = allSeasons[0].server;
                      if(link!=null&&link.isNotEmpty&&link=="link"){
                        return WebViewApp(server);
                      }else if(link!=null&&link.isNotEmpty&&link=="link_external"){
                        return OpenPdfExternal(title,server);
                      }else{
                        return WebViewScreen(title, allSeasons);
                      }
                    } else {
                      return Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: allSeasons.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 5.0,
                                        bottom: 5.0),
                                    child: Ink(
                                      child: Card(
                                        color: AdManager
                                            .getNeumorphicBackgroundColor(),
                                        elevation: 18.0,
                                        child: new Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: ListTile(
                                            onTap: () {
                                              showAds++;
                                              if (showAds % 3 == 0) {
                                                showAdmobFullScreenAds();
                                              }else{
                                                showAdmobFullScreenAds();
                                              }
                                              goTo(hasCategory,context,index);

                                            },
                                            contentPadding: EdgeInsets.all(15),
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                allSeasons[index].name,
                                                style: GoogleFonts.cairo(
                                                    textStyle: TextStyle(
                                                      color: AdManager.getTextColor(),
                                                      fontSize: 16.0,
                                                    )),
                                                maxLines: 2,
                                              ),
                                            ),

                                            leading: allSeasons[index].img.isNotEmpty ? Image.network(allSeasons[index].img,width: 40,height: 40,) : Icon(
                                              Icons.menu_book_sharp,
                                              color: Colors.white,
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
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                } else {
                  return showDataOffline(widget.api_url);
                }
              }),
        ),
      ),
    );
  }
  void goTo(String type,BuildContext context,int index) {
    type = ""+  allSeasons[index].hasCategory;
    switch (type) {
      case 'tasbeeh':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return tasbeeh();
        }));
        break;

      case 'listen_naats':
        AudioCategories.homeScreenStr = "";
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AudioCategories("Listen Naats",
              "https://example.com/apps/api/myserver_naats.json");
        }));
        break;
      case 'quran_reciters':
        QuranReciters.quran_reciters = "";
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QuranReciters("Quran Reciters",
              "https://example.com/apps/api/quran_reciters_api.json",true);
        }));
        break;
      case 'quran_translations':
        QuranReciters.quran_reciters = "";
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QuranReciters("Quran Translations",
              "https://muslims.host/apps/ios_apps/ReadAndListenQuran/v1/quran_translations_api.json",true);
        }));
        break;
      case 'read_quran':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReadQuran("Read Quran",
              "https://example.com/apps/api/read_quran_api.json",true);
          //  return MultipleGridView( );
        }));
        break;
      case 'read_books':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BooksCategories("Islamic Books",
              "https://example.com/apps/books/api/islamic_books.json");
          //  return MultipleGridView( );
        }));
        break;
      case 'rate_us':
        if (Platform.isAndroid) {
          LaunchReview.launch(
              androidAppId: "" + AdManager.packageName);
        } else {
          LaunchReview.launch(iOSAppId: "" + AdManager.packageName);
        }
        break;
      case 'more_apps':
        _launchURL();
        break;
      case 'web':
        String server =
            allSeasons[index].server;
        _launchWebURL(server);
        break;
      case 'share_app':
        if (Platform.isAndroid) {
          Share.share(
              'Please install this best application from Google Play Store and share it with your friends. Thanks\n ' +
                  AdManager.shareUrl,
              subject: 'Look what I made!');
        } else {
          Share.share(
              'Please install this best application from ios App Store and share it with your friends. Thanks\n ' +
                  AdManager.shareUrl,
              subject: 'Look what I made!');
        }
        break;
      default:
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) {
                  String server =
                      allSeasons[index].server;
                  String title =
                      allSeasons[index].name;
                  String hasCategory =
                      allSeasons[index].hasCategory;

                  if (hasCategory.isEmpty ||server.isEmpty) {

                    return Center(child: Container(child: Text("No data found",style: TextStyle(color: AdManager.getTextColor(),fontSize: 14.0),),));
                  }else if (hasCategory == "no") {

                    String link = allSeasons[0].fileName;
                    if(link!=null&&link.isNotEmpty&&link=="link"){
                      return WebViewApp(server);
                    }else{
                      return WebViewScreen(title, allSeasons);
                    }
                  } else {
                    return BooksCategories(
                        "" + allSeasons[index].name,
                        AdManager.baseURL +
                            "" +
                            allSeasons[index]
                                .server);

                  }

                }));
        break;
    }
  }
  _launchWebURL(String url) async {


    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL() async {
    String url =
        'https://apps.apple.com/us/developer/mohammed-alsalak/id1609226760#see-all/i-phonei-pad-apps';
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/dev?id=6694032292184630684';
    } else {
      url =
      'https://apps.apple.com/us/developer/mohammed-alsalak/id1609226760#see-all/i-phonei-pad-apps';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
