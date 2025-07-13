import 'package:naat_app/ReadOffline/PageDetailOffline.dart';
import 'package:naat_app/constans.dart';
import 'package:naat_app/pagerDetail.dart';
import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';

import '../AdManager.dart';


class QuranTabs extends StatelessWidget {
  String title = "16 line Quran";
  String Server= "imgfiles/";
  String file_name="page";
  String count="549";
  String ext=".png";
  String surah_pages="1,2,45,69,96,115,136,159,168,187,199,212,224,230,235,240,254,264,275,281,290,299,308,315,324,330,339,347,357,364,370,373,376,385,391,396,401,408,412,420,429,434,440,446,448,452,456,460,463,466,468,471,473,475,478,481,484,488,491,495,497,499,500,502,504,506,508,510,512,514,516,518,520,521,523,524,526,528,529,530,532,532,533,534,535,536,537,537,538,539,540,540,541,541,542,542,543,543,544,544,544,545,545,545,546,546,546,546,547,547,547,547,548,548";
  String parahs_pages="1,20,38,56,74,92,110,128,146,164,182,200,218,236,254,272,290,308,326,344,362,380,398,416,435,452,470,488,508,528";

  @override  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  AdManager.getNeumorphicBackgroundColor(),
            flexibleSpace:  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TabBar(

                    labelStyle: GoogleFonts.cairo(textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                    indicatorColor: Colors.white,
                    tabs: [

                      Tab(text: "Select Surah"),
                      Tab(text: "Select Parah"),
                    ],
                  ),
                ],
              ),
            ),
        ),
        body: TabBarView(
          children: [

            SurahsList(  title,  Server,  file_name,  count,  ext,  surah_pages,  parahs_pages),
            ParahsList(  title,  Server,  file_name,  count,  ext,  surah_pages,  parahs_pages),
          ],
        ),
      ),
    );
  }
}

class SurahsList extends StatefulWidget {
 late String title;
 late String Server;
 late String file_name;
 late String count;
 late String ext;
 late String surah_pages;
 late String parahs_pages;
  SurahsList(String title,String Server,String file_name,String count,String ext,String surah_pages,String parahs_pages){
    this.title = title;
    this.Server=Server;
    this.file_name=file_name;
    this.count=count;
    this.ext=ext;
    this.surah_pages=surah_pages;
    this.parahs_pages=parahs_pages;
  }

  @override
  _SurahsListState createState() => _SurahsListState();
}

class _SurahsListState extends State<SurahsList> {

  List allSurahNames = [
    "الفاتحة",
    "البقرة",
    "آل عمران",
    "النساء",
    "المائدة",
    "الأنعام",
    "الأعراف",
    "الأنفال",
    "التوبة",
    "يونس",
    "هود",
    "يوسف",
    "الرعد",
    "ابراهيم",
    "الحجر",
    "النحل",
    "الإسراء",
    "الكهف",
    "مريم",
    "طه",
    "الأنبياء",
    "الحج",
    "المؤمنون",
    "النور",
    "الفرقان",
    "الشعراء",
    "النمل",
    "القصص",
    "العنكبوت",
    "الروم",
    "لقمان",
    "السجدة",
    "الأحزاب",
    "سبإ",
    "فاطر",
    "يس",
    "الصافات",
    "ص",
    "الزمر",
    "غافر",
    "فصلت",
    "الشورى",
    "الزخرف",
    "الدخان",
    "الجاثية",
    "الأحقاف",
    "محمد",
    "الفتح",
    "الحجرات",
    "ق",
    "الذاريات",
    "الطور",
    "النجم",
    "القمر",
    "الرحمن",
    "الواقعة",
    "الحديد",
    "المجادلة",
    "الحشر",
    "الممتحنة",
    "الصف",
    "الجمعة",
    "المنافقون",
    "التغابن",
    "الطلاق",
    "التحريم",
    "الملك",
    "القلم",
    "الحاقة",
    "المعارج",
    "نوح",
    "الجن",
    "المزمل",
    "المدثر",
    "القيامة",
    "الانسان",
    "المرسلات",
    "النبإ",
    "النازعات",
    "عبس",
    "التكوير",
    "الإنفطار",
    "المطففين",
    "الإنشقاق",
    "البروج",
    "الطارق",
    "الأعلى",
    "الغاشية",
    "الفجر",
    "البلد",
    "الشمس",
    "الليل",
    "الضحى",
    "الشرح",
    "التين",
    "العلق",
    "القدر",
    "البينة",
    "الزلزلة",
    "العاديات",
    "القارعة",
    "التكاثر",
    "العصر",
    "الهمزة",
    "الفيل",
    "قريش",
    "الماعون",
    "الكوثر",
    "الكافرون",
    "النصر",
    "المسد",
    "الإخلاص",
    "الفلق",
    "الناس"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AdManager.getNeumorphicBackgroundColor(),
      child: ListView.builder(
        itemCount: 114,
        itemBuilder: (BuildContext context, int index) {
          int paraNumber = index+1;
          String surah = allSurahNames[index]+"";
          String mSurah = "سُورَة‎";
          if (index ==1) {
            return Column(children: [
              //showNativeBannerAd(),
              Container(
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
                          String server = widget.Server;
                          String title = widget.title;
                          String total_pages = widget.count;
                          String file_name = widget.file_name;
                          String ext = widget.ext;
                          List surahsList = [];
                          List surahsIndexesList = widget.surah_pages
                              .split(',') // split the text into an array
                              .toList();
                          for (int i = 0; i < surahsIndexesList.length; i++) {
                            var index = surahsIndexesList[i];

                            String surahName = surahsIndexesList[i];
                            if (surahName != null && surahName.isNotEmpty) {
                              surahsList.add(surahName);
                            }
                          }
                          int currentPos = int.parse(surahsList[index]);
                          currentPos =currentPos-1;

                          Navigator.push(context, MaterialPageRoute(builder:(context){
                            return  MyPageViewOffline(title,server,total_pages,file_name,ext,currentPos);
                          }));
                        },
                        contentPadding: EdgeInsets.all(15),
                        title: Center(
                          child: Text(
                            mSurah+" "+surah,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.cairo(textStyle: TextStyle(
                              color: AdManager.getTextColor(),
                              fontSize: 22.0,
                            )),
                          ),
                        ),
                        /*subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "",
                        style: GoogleFonts.cairo(textStyle: TextStyle(
                                        color: AdManager.getNeumorphicBackgroundColor(),
                                        fontSize: 14.0,
                                      )),
                        maxLines: 2,),
                    ),*/
                        trailing:  Text(
                          '.$paraNumber',
                          style: GoogleFonts.cairo(textStyle: TextStyle(
                            color: AdManager.getTextColor(),
                            fontSize: 22.0,
                          )),
                        ),
                        leading: Card(
                          elevation: 18.0,
                          color: Color(0x000000),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.menu_book_outlined,
                              color: AdManager.getNeumorphicBackgroundColor(),
                            ),
                            backgroundColor: AdManager.getTextColor(),
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
                  color: AdManager.getNeumorphicBackgroundColor(),
                  elevation: 18.0,
                  child: Container(
                    child: ListTile(
                      onTap: () {
                          showAdmobFullScreenAds();
                        String server = widget.Server;
                        String title = widget.title;
                        String total_pages = widget.count;
                        String file_name = widget.file_name;
                        String ext = widget.ext;
                        List surahsList = [];
                        List surahsIndexesList = widget.surah_pages
                            .split(',') // split the text into an array
                            .toList();
                        for (int i = 0; i < surahsIndexesList.length; i++) {
                          var index = surahsIndexesList[i];

                          String surahName = surahsIndexesList[i];
                          if (surahName != null && surahName.isNotEmpty) {
                            surahsList.add(surahName);
                          }
                        }
                        int currentPos = int.parse(surahsList[index]);
                        currentPos =currentPos-1;

                        Navigator.push(context, MaterialPageRoute(builder:(context){
                          return  MyPageViewOffline(title,server,total_pages,file_name,ext,currentPos);
                        }));
                      },
                      contentPadding: EdgeInsets.all(15),
                      title: Center(
                        child: Text(
                          mSurah+" "+surah,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.cairo(textStyle: TextStyle(
                            color: AdManager.getTextColor(),
                            fontSize: 22.0,
                          )),
                        ),
                      ),
                      /*subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "",
                        style: GoogleFonts.cairo(textStyle: TextStyle(
                                        color: AdManager.getNeumorphicBackgroundColor(),
                                        fontSize: 14.0,
                                      )),
                        maxLines: 2,),
                    ),*/
                      trailing:  Text(
                        '.$paraNumber',
                        style: GoogleFonts.cairo(textStyle: TextStyle(
                          color: AdManager.getTextColor(),
                          fontSize: 22.0,
                        )),
                      ),
                      leading: Card(
                        elevation: 18.0,
                        color: Color(0x000000),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.menu_book_outlined,
                            color: AdManager.getNeumorphicBackgroundColor(),
                          ),
                          backgroundColor: AdManager.getTextColor(),
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
  }
}

class ParahsList extends StatefulWidget {
 late String title;
 late String Server;
 late String file_name;
 late String count;
 late String ext;
 late String surah_pages;
 late String parahs_pages;
  ParahsList(String title,String Server,String file_name,String count,String ext,String surah_pages,String parahs_pages){
    this.title = title;
    this.Server=Server;
    this.file_name=file_name;
    this.count=count;
    this.ext=ext;
    this.surah_pages=surah_pages;
    this.parahs_pages=parahs_pages;
  }

  @override
  _ParahsListState createState() => _ParahsListState();
}

class _ParahsListState extends State<ParahsList> {
  List parahList = [
    "الم",
    "سَيَقُولُ",
    "تِلْكَ الرُّسُلُ",
    "لَنْ تَنَالُوا",
    "وَالْمُحْصَنَاتُ",
    "لَا يُحِبُّ اللَّهُ",
    "وَإِذَا سَمِعُوا",
    "وَلَوْ أَنَّنَا",
    "قَالَ الْمَلَأُ",
    "وَاعْلَمُوا",
    "يَعْتَذِرُونَ",
    "وَمَا مِنْ دَابَّةٍ",
    "وَمَا أُبَرِّئُ",
    "رُبَمَا",
    "سُبْحَانَ الَّذِي",
    "قَالَ أَلَمْ",
    "اقْتَرَبَ",
    "قَدْ أَفْلَحَ",
    "وَقَالَ الَّذِينَ",
    "أَمَّنْ خَلَقَ",
    "اتْلُ مَا أُوحِيَ",
    "وَمَنْ يَقْنُتْ",
    "وَمَا لِيَ",
    "فَمَنْ أَظْلَمُ",
    "إِلَيْهِ يُرَدُّ",
    "حم",
    "قَالَ فَمَا خَطْبُكُمْ",
    "قَدْ سَمِعَ اللَّهُ",
    "تَبَارَكَ الَّذِي",
    "عَمَّ يَتَسَاءَلُونَ "
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AdManager.getNeumorphicBackgroundColor(),
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          int parahNo = index+1;

          if (index ==1) {
            return Column(children: [
              //   showNativeBannerAd(),
              Container(
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
                          String server = widget.Server;
                          String title = widget.title;
                          String total_pages = widget.count;
                          String file_name = widget.file_name;
                          String ext = widget.ext;
                          List surahsList = [];
                          List surahsIndexesList = widget.parahs_pages
                              .split(',') // split the text into an array
                              .toList();
                          for (int i = 0; i < surahsIndexesList.length; i++) {
                            var index = surahsIndexesList[i];

                            String surahName = surahsIndexesList[i];
                            if (surahName != null && surahName.isNotEmpty) {
                              surahsList.add(surahName);
                            }
                          }
                          int currentPos = int.parse(surahsList[index]);
                          currentPos =currentPos-1;
                          Navigator.push(context, MaterialPageRoute(builder:(context){
                            return  MyPageViewOffline(title,server,total_pages,file_name,ext,currentPos);
                          }));

                        },
                        contentPadding: EdgeInsets.all(15),
                        title: Center(
                          child: Text(
                            ''+parahList[index],
                            style: GoogleFonts.cairo(textStyle: TextStyle(
                              color: AdManager.getTextColor(),
                              fontSize: 22.0,
                            )),
                          ),
                        ),
                        /* subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "",
                        style: TextStyle(
                            color: AdManager.getNeumorphicBackgroundColor(),
                            fontSize: 16.0,
                            fontFamily: "Raleway"),
                        maxLines: 2,),
                    ),*/
                        trailing: Text(
                          '.$parahNo ',
                          style: GoogleFonts.cairo(textStyle: TextStyle(
                            color: AdManager.getTextColor(),
                            fontSize: 22.0,
                          )),
                        ),
                        leading: Card(
                          elevation: 18.0,
                          color: Color(0x000000),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.menu_book_outlined,
                              color: AdManager.getNeumorphicBoxShadowColorDark(),
                            ),
                            backgroundColor: AdManager.getTextColor(),
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
                  color: AdManager.getNeumorphicBackgroundColor(),
                  elevation: 18.0,
                  child: Container(
                    child: ListTile(
                      onTap: () {
                          showAdmobFullScreenAds();
                        String server = widget.Server;
                        String title = widget.title;
                        String total_pages = widget.count;
                        String file_name = widget.file_name;
                        String ext = widget.ext;
                        List surahsList = [];
                        List surahsIndexesList = widget.parahs_pages
                            .split(',') // split the text into an array
                            .toList();
                        for (int i = 0; i < surahsIndexesList.length; i++) {
                          var index = surahsIndexesList[i];

                          String surahName = surahsIndexesList[i];
                          if (surahName != null && surahName.isNotEmpty) {
                            surahsList.add(surahName);
                          }
                        }
                        int currentPos = int.parse(surahsList[index]);
                        currentPos =currentPos-1;
                        Navigator.push(context, MaterialPageRoute(builder:(context){
                          return  MyPageViewOffline(title,server,total_pages,file_name,ext,currentPos);
                        }));

                      },
                      contentPadding: EdgeInsets.all(15),
                      title: Center(
                        child: Text(
                          ''+parahList[index],
                          style: GoogleFonts.cairo(textStyle: TextStyle(
                            color: AdManager.getTextColor(),
                            fontSize: 22.0,
                          )),
                        ),
                      ),
                      /* subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "",
                        style: TextStyle(
                            color: AdManager.getNeumorphicBackgroundColor(),
                            fontSize: 16.0,
                            fontFamily: "Raleway"),
                        maxLines: 2,),
                    ),*/
                      trailing: Text(
                        '.$parahNo ',
                        style: GoogleFonts.cairo(textStyle: TextStyle(
                          color: AdManager.getTextColor(),
                          fontSize: 22.0,
                        )),
                      ),
                      leading: Card(
                        elevation: 18.0,
                        color:Color(0x000000),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.menu_book_outlined,
                            color: AdManager.getNeumorphicBoxShadowColorDark(),
                          ),
                          backgroundColor: AdManager.getTextColor(),
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
  }
}

