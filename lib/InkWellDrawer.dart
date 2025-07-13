import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AdManager.dart';


class InkWellDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              AdManager.getNeumorphicBoxShadowColorDark(),
              AdManager.getNeumorphicBoxShadowColorLight(),
            ])),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        AdManager.getNeumorphicBoxShadowColorDark(),
                        AdManager.getNeumorphicBoxShadowColorLight(),
                      ])),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.queue_music_outlined,
                          size: 70,
                          color: Colors.white,
                        ),
                        Text(
                          AdManager.appName,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              color: Colors.white),
                        )
                      ],
                    ),
                  )),


              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.pop(ctxt);
                          goTo("rate_us", ctxt);
                        },
                        child: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star_border_outlined,
                                      color: AdManager.getTextColor(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                    Text(
                                      "Rate Us",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AdManager.getTextColor(),
                                )
                              ],
                            ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.pop(ctxt);
                          goTo("more_apps", ctxt);
                        },
                        child: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.read_more_outlined,
                                      color: AdManager.getTextColor(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                    Text(
                                      "More Apps",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AdManager.getTextColor(),
                                )
                              ],
                            ))),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                        splashColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.pop(ctxt);
                          goTo("share_app", ctxt);
                        },
                        child: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.share_outlined,
                                      color: AdManager.getTextColor(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                    Text(
                                      "Share",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AdManager.getTextColor(),
                                )
                              ],
                            ))),
                  ),
                ),
              ),
              CustomListTileEsset('assets/images/ic_facebook.png', 'Facebook', ()=>{
                Navigator.pop(ctxt),
                _launchWebURL("https://www.facebook.com/%D8%A7%D9%84%D9%85%D8%B9%D9%84%D9%85-%D8%A7%D9%84%D8%A7%D9%84%D9%83%D8%AA%D8%B1%D9%88%D9%86%D9%8A-%D8%A7%D9%84%D8%B4%D8%A7%D9%85%D9%84-100658468194890"),
              }),
              CustomListTileEsset('assets/images/ic_whatsapp.png', 'WhatsApp', ()=>{
                Navigator.pop(ctxt),
                _launchWebURL("https://wa.me/+962799186062")
              }),
              CustomListTileEsset('assets/images/ic_twitter.png', 'Twitter', ()=>{
                Navigator.pop(ctxt),
                _launchWebURL("https://twitter.com/moallemelect")
              }),
            ],
          ),
        ),
      ),
    );
  }
  _launchWebURL(String url) async {


    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void goTo(String type, BuildContext context) {
    switch (type) {

      case 'rate_us':
        if (Platform.isAndroid) {
          LaunchReview.launch(androidAppId: "" + AdManager.packageName);
        } else {
          LaunchReview.launch(iOSAppId: "" + AdManager.packageName);
        }
        break;
      case 'more_apps':
        _launchURL();
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
    }
  }

  _launchURL() async {
    String url =
        'https://apps.apple.com/us/developer/rashid-zia/id1537402699#see-all/i-phonei-pad-apps';
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/developer?id=Bilali';
    } else {
      url =
      'https://apps.apple.com/us/developer/rashid-zia/id1537402699#see-all/i-phonei-pad-apps';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              splashColor: Colors.orangeAccent,
              onTap: onTap(),
              child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            icon,
                            color: AdManager.getTextColor(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                          ),
                          Text(
                            text,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AdManager.getTextColor(),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}

class CustomListTileEsset extends StatelessWidget{

  final String icon;
  final  String text;
  final VoidCallback onTap;

  CustomListTileEsset(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context){
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child:Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))
        ),
        child: Padding(
          padding: const EdgeInsets.all( 10.0),
          child: InkWell(
              splashColor: Colors.transparent,
              onTap: onTap,
              child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Image.asset(icon,width: 30,height: 30,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(text, style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            color: Colors.white
                        ),),
                      ],),
                      Icon(Icons.arrow_forward,color: AdManager.getTextColor(),)
                    ],)
              )
          ),
        ),
      ),
    );
  }
}

