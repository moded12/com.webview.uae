import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naat_app/BookSection/BookParts.dart';
import 'package:naat_app/BookSection/StartScreen.dart';
import 'package:naat_app/AdManager.dart';
import 'package:naat_app/PushNotification.dart';
import 'package:naat_app/apiConstants.dart';
import 'package:naat_app/audio_categories/AudioCategories.dart';
import 'package:naat_app/audio_categories/QuranReciters.dart';
import 'package:naat_app/books_categories/BooksCategories.dart';
import 'package:naat_app/books_categories/OnlineBooksFirebase.dart';
import 'package:naat_app/books_categories/ReadQuran.dart';
import 'package:naat_app/services.dart';
import 'package:naat_app/tasbeeh.dart';
import 'package:naat_app/video_categories/VideoCategories.dart';
import 'package:naat_app/wallpapers_categories/WallpaperCategories.dart';
import 'package:naat_app/youtube_categories/PlayListVideos.dart';
import 'package:flutter/services.dart';
import 'package:naat_app/constans.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
 import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'AdManager.dart';
import 'InkWellDrawer.dart';
import 'app_lifecycle_reactor.dart';
import 'app_open_ad_manager.dart';
 var box;
bool notificationClicked = false;
  String notificationProductType = "";
String notificationProductName = "";
String notificationProductImage = "";
int notificationProductId = 0;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Wakelock.enable();
  await Hive.initFlutter();
  box = await Hive.openBox('almualimDB');

  /// Init MobileAds and more configs
  await MobileAds.instance.initialize().then((value) {
    MobileAds.instance.updateRequestConfiguration(
      //Add more configs
      RequestConfiguration(testDeviceIds: ['496D874B3338DFC827B1D89327CA5B9D']),
    );
  });




  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    // home: MyApp(),
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
@override
_SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => loadAppLaunchData())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff55AE59),
      body: Center(
        child: Image.asset('assets/images/splash.png'),
      ),
    );
  }
}
class loadAppLaunchData extends StatefulWidget {
  static String APP_BASE_URL = "";
  @override
  _loadAppLaunchDataState createState() => _loadAppLaunchDataState();
}

class _loadAppLaunchDataState extends State<loadAppLaunchData> {
  late AppLifecycleReactor _appLifecycleReactor;
  void registerNotification() async {
    await Firebase.initializeApp();




  }

  consentF () async {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      //  await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      //  await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      //  await AppTrackingTransparency.requestTrackingAuthorization();
      WidgetsFlutterBinding.ensureInitialized()
          .addPostFrameCallback((_) async {
        await Future.delayed(const Duration(milliseconds: 2000));
        await AppTrackingTransparency.requestTrackingAuthorization();
        await Future.delayed(const Duration(milliseconds: 2000));

        // final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
        ConsentDebugSettings debugSettings = ConsentDebugSettings(
            debugGeography: DebugGeography.debugGeographyEea,
            testIdentifiers: [
              '496D874B3338DFC827B1D89327CA5B9D',
            ]);
        final params = ConsentRequestParameters(

            consentDebugSettings: debugSettings
        );
        ConsentInformation.instance.requestConsentInfoUpdate(
          params,
              () async {
            if (await ConsentInformation.instance.isConsentFormAvailable()) {
              loadForm();
            }
          },
              (FormError error) {
            // Handle the error
          },
        );
      });
    }else {
      final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
      ConsentDebugSettings debugSettings = ConsentDebugSettings(
          debugGeography: DebugGeography.debugGeographyEea,
          testIdentifiers: [
            '496D874B3338DFC827B1D89327CA5B9D',
            '00000000-0000-0000-0000-000000000000',
            uuid
          ]);
      final params = ConsentRequestParameters(

          consentDebugSettings: debugSettings
      );
      ConsentInformation.instance.requestConsentInfoUpdate(
        params,
            () async {
          if (await ConsentInformation.instance.isConsentFormAvailable()) {
            loadForm();
          }
        },
            (FormError error) {
          // Handle the error
        },
      );
    }
  }
  void loadForm() {
    ConsentForm.loadConsentForm(
          (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        if (status == ConsentStatus.required) {
          consentForm.show(
                (FormError? formError) {
              // Handle dismissal by reloading form
              loadForm();
            },
          );
        }
      },
          (formError) {
        // Handle the error
      },
    );
  }
  @override
  void initState() {
    consentF();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();

    // TODO: implement initState
    super.initState();
  }
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {

            },
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  TabBarViews();
  }
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class TabBarViews extends StatefulWidget {
  @override
  _TabBarViewsState createState() => _TabBarViewsState();
}

class _TabBarViewsState extends State<TabBarViews> {
  late DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadInAppWidget() {
    return IconButton(
      iconSize: 50,
      icon: Image.asset('assets/images/star.png'),
      onPressed: () {
        if (Platform.isAndroid) {
          LaunchReview.launch(androidAppId: "" + AdManager.packageName);
        } else {
          LaunchReview.launch(iOSAppId: "" + AdManager.packageName);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreenInAppPurchase(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: InkWellDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: AdManager.getTextColor()),
            backgroundColor: AdManager.getNeumorphicBackgroundColor(),
            bottom: TabBar(
              labelStyle: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  color: Colors.white),
              indicatorColor: AdManager.getTextColor(),
              tabs: [
                /*Tab(
                  text: "Read",
                ),*/
                Tab(
                  text: "المعلم الالكتروني الامارات",
                ),
                Tab(
                  text: "القرآن الكريم",
                ),

                /*  Tab(text: "More"),*/
              ],
            ),
            title: Center(
              child: Text(
                'المعلم الالكتروني الامارات',
                style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        color: AdManager.getTextColor(),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            actions: <Widget>[
              loadInAppWidget() == null
                  ? IconButton(
                iconSize: 50,
                icon: Image.asset('assets/images/star.png'),
                onPressed: () {
                  if (Platform.isAndroid) {
                    LaunchReview.launch(
                        androidAppId: "" + AdManager.packageName);
                  } else {
                    LaunchReview.launch(
                        iOSAppId: "" + AdManager.packageName);
                  }
                },
              )
                  : loadInAppWidget(),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [

                      BooksCategories("",DASHBOARD_API),

                      QuranReciters(
                          "Quran Reciters",
                          "https://www.shneler.com/e-learning/listen_quran/quran_reciters_api.json",
                          false)

                    ],
                  ),
                ),
               // LoadAdmobBannerAds(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnlineTabs extends StatefulWidget {
  @override
  _OnlineTabsState createState() => _OnlineTabsState();
}

class _OnlineTabsState extends State<OnlineTabs> {
  String loadApiData = "";
  String readQuranUrl = "";
  String listenQuranUrl = "";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //prints correct path

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AdManager.getNeumorphicBackgroundColor(),
          flexibleSpace: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  labelStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                    color: AdManager.getTextColor(),
                    fontSize: 16.0,
                  )),
                  indicatorColor: AdManager.getTextColor(),
                  tabs: [
                    Tab(text: "Read Quran"),
                    Tab(text: "Listen Quran"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ReadQuran(
                "Read Quran",
                "https://example.com/apps/api/read_quran_api.json",
                false),
            // ReadQuran("Read Quran", readQuranUrl),
            QuranReciters(
                "Quran Reciters",
                "https://example.com/apps/api/quran_reciters_api.json",
                false)
            //  "Quran Reciters",listenQuranUrl)
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    showAdmobFullScreenAds();
    return MaterialApp(
      title: AdManager.appName,
      debugShowCheckedModeBanner: false,
      home: MyBottomNavigationBarDemo(),
    );
  }
}

class MyBottomNavigationBarDemo extends StatefulWidget {
  @override
  _MyBottomNavigationBarDemoState createState() =>
      _MyBottomNavigationBarDemoState();
}

  showBody(int index) {
  switch (index) {
    case 0:
      return BookParts();

      break;
    case 1:
      return OnlineBooksFirebase();

      break;
    case 2:
      return StartScreen();

      break;
    case 3:
      return ReadQuran("Read Quran",
          "https://example.com/apps/api/read_quran_api.json", true);
      //  return MultipleGridView( );

      break;
    case 4:
      return StartScreen();

      break;
  }
}

class _MyBottomNavigationBarDemoState extends State<MyBottomNavigationBarDemo> {
  int currentIndex = 0;
  late DateTime currentBackPressTime;
  late bool _isInterstitialAdReady;

  // InterstitialAd _interstitialAd;
  @override
  void initState() {
    super.initState();

    // FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    // TODO: Initialize _bannerAd

    // TODO: Load a Banner Ad

    //   _isInterstitialAdReady = false;
    /* _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );*/
  }

  /* void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
setState(() {
  _interstitialAd = InterstitialAd(
    adUnitId: AdManager.interstitialAdUnitId,
    listener: _onInterstitialAdEvent,
  );
});
        break;
      default:
      // do nothing
    }
  }*/
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    //   _interstitialAd.load();
    return Scaffold(
      backgroundColor: AdManager.getNeumorphicBoxShadowColorDark(),
      /*  appBar: AppBar(
        title: Center(
            child: Text(
          'المعلم الالكتروني الامارات',
          style: GoogleFonts.cairo(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          )),
        )),
        backgroundColor: AdManager.getNeumorphicBoxShadowColorDark(),
      ),*/
      body: WillPopScope(
        child: Column(
          children: [
            Expanded(child: showBody(currentIndex)),
            LoadAdmobBannerAds(),
          ],
        ),
        onWillPop: onWillPop,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AdManager.getNeumorphicBoxShadowColorLight(),
        color: AdManager.getNeumorphicBoxShadowColorDark(),
        buttonBackgroundColor: AdManager.getNeumorphicBoxShadowColorDark(),
        height: 60,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: currentIndex,
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.menu_book_outlined, size: 30, color: Colors.white),
          Icon(Icons.more_horiz, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          //Handle button tap

          switch (index) {
            case 4:
              currentIndex = index;
              setState(() {
                showBody(currentIndex);
              });
              break;
            case 0:
              currentIndex = index;
              setState(() {
                showBody(currentIndex);
              });
              break;
            case 1:
              currentIndex = index;
              setState(() {
                showBody(currentIndex);
              });
              break;
            case 2:
              currentIndex = index;
              setState(() {
                showBody(currentIndex);
              });
              break;
            case 3:
              currentIndex = index;
              setState(() {
                showBody(currentIndex);
              });
              break;
          }
        },
      ),
    );
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(true);
    }
    return Future.value(true);
  }

  void goTo(String type) {
    switch (type) {
      case 'tasbeeh':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return tasbeeh();
        }));
        break;

      case 'listen_naats':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AudioCategories("المعلم الالكتروني الامارات",
              "https://example.com/apps/api/myserver_naats.json");
        }));
        break;
      case 'quran_reciters':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QuranReciters(
              "Quran Reciters",
              "https://example.com/apps/api/quran_reciters_api.json",
              true);
        }));
        break;
      case 'quran_translations':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QuranReciters(
              "Quran Translations",
              "https://example.com/apps/ios_apps/ReadAndListenQuran/v1/quran_translations_api.json",
              true);
        }));
        break;
      case 'read_quran':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReadQuran(
              "Read Quran",
              "https://example.com/apps/api/read_quran_api.json",
              true);
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
          LaunchReview.launch(androidAppId: AdManager.packageName);
        } else if (Platform.isIOS) {
          LaunchReview.launch(iOSAppId: AdManager.packageName);
        }

        break;
      case 'more_apps':
        _launchURL();
        break;
      case 'share_app':
        if (Platform.isAndroid) {
          Share.share(
              'Please install this best Islamic application from Google Play Store and share it with your friends. Thanks\n ' +
                  AdManager.shareUrl,
              subject: 'Look what I made!');
        } else if (Platform.isIOS) {
          Share.share(
              'Please install this best Islamic application from ios App Store and share it with your friends. Thanks\n ' +
                  AdManager.shareUrl,
              subject: 'Look what I made!');
        }

        break;
    }
  }

  _launchURL() async {
    const url =
        'https://apps.apple.com/us/developer/mohammed-alsalak/id1609226760#see-all/i-phonei-pad-apps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List allSeasons = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FutureBuilder(
            future: getApiResponse(VIDEO_CATEGORY),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  //      setSharedPreferences(VIDEO_CATEGORY, snapshot.data.toString());
                  var convertedJson = jsonDecode(snapshot.data.toString());
                  allSeasons = convertedJson['dashboard'];
                  return Container(
                    child: ListView.builder(
                      itemCount: allSeasons.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 1) {
                          return Column(
                            children: [
                              //     showNativeBannerAd(),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                child: Ink(
                                  child: Card(
                                    elevation: 18.0,
                                    child: Container(
                                      child: ListTile(
                                        onTap: () {
                                          showAdmobFullScreenAds();
                                          String type =
                                              allSeasons[index]['type'];
                                          switch (type) {
                                            case 'tasbeeh':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return tasbeeh();
                                              }));
                                              break;
                                            case 'my_server_videos':
                                              String title =
                                                  allSeasons[index]['title'];
                                              String description =
                                                  allSeasons[index]
                                                      ['description'];
                                              String api_url =
                                                  allSeasons[index]['api_url'];
                                              if (api_url.contains(".mp4")) {
                                              } else {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return VideoCategories(
                                                      title, api_url);
                                                }));
                                              }
                                              break;
                                            case 'youtube_videos':
                                              String title =
                                                  allSeasons[index]['title'];
                                              String id =
                                                  allSeasons[index]['id'];
                                              String api_url =
                                                  allSeasons[index]['api_url'];
                                              if (id.isNotEmpty &&
                                                  id.contains("1")) {
                                                String requestURL =
                                                    "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=" +
                                                        api_url +
                                                        "&key=AIzaSyDQ_ebWYPb4ajXCitVjQy9CbMMMv9RVubk";

                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return PlayListVideos(
                                                      title, requestURL);
                                                }));
                                              } else {
                                                /* Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return VideoScreen(api_url);
                                                }));*/
                                              }
                                              break;

                                            case 'listen_naats':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];
                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];
                                                print(api_url);
                                                return AudioCategories(
                                                    title, api_url);
                                              }));
                                              break;
                                            case 'quran_reciters':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];
                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];
                                                return QuranReciters(
                                                    title, api_url, true);
                                              }));
                                              break;
                                            case 'read_quran':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];

                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];

                                                return ReadQuran(
                                                    title, api_url, true);
                                                //  return MultipleGridView( );
                                              }));
                                              break;
                                            case 'read_books':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];

                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];

                                                return BooksCategories(
                                                    title, api_url);
                                                //  return MultipleGridView( );
                                              }));
                                              break;
                                          }
                                        },
                                        contentPadding: EdgeInsets.all(15),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['title'],
                                            style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
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
                                            style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12.0,
                                            )),
                                            maxLines: 2,
                                          ),
                                        ),
                                        leading: Card(
                                          elevation: 15.0,
                                          child: CachedNetworkImage(
                                            width: 80,
                                            height: 80,
                                            imageUrl: allSeasons[index]['img'],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.network(
                                              "https://via.placeholder.com/200x150",
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                            child: Ink(
                              child: Card(
                                elevation: 18.0,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      showAdmobFullScreenAds();
                                      String type = allSeasons[index]['type'];
                                      switch (type) {
                                        case 'tasbeeh':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return tasbeeh();
                                          }));
                                          break;
                                        case 'my_server_videos':
                                          String title =
                                              allSeasons[index]['title'];
                                          String description =
                                              allSeasons[index]['description'];
                                          String api_url =
                                              allSeasons[index]['api_url'];
                                          if (api_url.contains(".mp4")) {
                                          } else {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return VideoCategories(
                                                  title, api_url);
                                            }));
                                          }
                                          break;
                                        case 'youtube_videos':
                                          String title =
                                              allSeasons[index]['title'];
                                          String id = allSeasons[index]['id'];
                                          String api_url =
                                              allSeasons[index]['api_url'];
                                          if (id.isNotEmpty &&
                                              id.contains("1")) {
                                            String requestURL =
                                                "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=" +
                                                    api_url +
                                                    "&key=AIzaSyDQ_ebWYPb4ajXCitVjQy9CbMMMv9RVubk";

                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return PlayListVideos(
                                                  title, requestURL);
                                            }));
                                          } else {
                                            /*Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return VideoScreen(api_url);
                                            }));*/
                                          }
                                          break;

                                        case 'listen_naats':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];
                                            String api_url =
                                                allSeasons[index]['api_url'];
                                            print(api_url);
                                            return AudioCategories(
                                                title, api_url);
                                          }));
                                          break;
                                        case 'quran_reciters':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];
                                            String api_url =
                                                allSeasons[index]['api_url'];
                                            return QuranReciters(
                                                title, api_url, true);
                                          }));
                                          break;
                                        case 'read_quran':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];

                                            String api_url =
                                                allSeasons[index]['api_url'];

                                            return ReadQuran(
                                                title, api_url, true);
                                            //  return MultipleGridView( );
                                          }));
                                          break;
                                        case 'read_books':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];

                                            String api_url =
                                                allSeasons[index]['api_url'];

                                            return BooksCategories(
                                                title, api_url);
                                            //  return MultipleGridView( );
                                          }));
                                          break;
                                      }
                                    },
                                    contentPadding: EdgeInsets.all(15),
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, bottom: 8.0),
                                      child: Text(
                                        allSeasons[index]['title'],
                                        style: GoogleFonts.cairo(
                                            textStyle: TextStyle(
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
                                        style: GoogleFonts.cairo(
                                            textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 12.0,
                                        )),
                                        maxLines: 2,
                                      ),
                                    ),
                                    leading: Card(
                                      elevation: 15.0,
                                      child: CachedNetworkImage(
                                        width: 80,
                                        height: 80,
                                        imageUrl: allSeasons[index]['img'],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Image.network(
                                          "https://via.placeholder.com/200x150",
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
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
    );
  }
}

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  List allSeasons = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FutureBuilder(
            future: getApiResponse(AUDIO_CATEGORY),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  var convertedJson = jsonDecode(snapshot.data.toString());
                  allSeasons = convertedJson['dashboard'];
                  return Container(
                    child: ListView.builder(
                      itemCount: allSeasons.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 1) {
                          return Column(
                            children: [
                              //      showNativeBannerAd(),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                child: Ink(
                                  child: Card(
                                    elevation: 18.0,
                                    child: Container(
                                      child: ListTile(
                                        onTap: () {
                                          showAdmobFullScreenAds();
                                          String type =
                                              allSeasons[index]['type'];
                                          switch (type) {
                                            case 'tasbeeh':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return tasbeeh();
                                              }));
                                              break;
                                            case 'listen_naats':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];
                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];
                                                print(api_url);
                                                return AudioCategories(
                                                    title, api_url);
                                              }));
                                              break;
                                            case 'quran_reciters':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];
                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];
                                                return QuranReciters(
                                                    title, api_url, true);
                                              }));
                                              break;
                                          }
                                        },
                                        contentPadding: EdgeInsets.all(15),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['title'],
                                            style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 16.0,
                                            )),
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['description'],
                                            style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12.0,
                                            )),
                                            maxLines: 2,
                                          ),
                                        ),
                                        leading: Card(
                                          elevation: 15.0,
                                          child: CachedNetworkImage(
                                            width: 80,
                                            height: 80,
                                            imageUrl: allSeasons[index]['img'],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.network(
                                              "https://via.placeholder.com/200x150",
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                            child: Ink(
                              child: Card(
                                elevation: 18.0,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      String type = allSeasons[index]['type'];
                                      switch (type) {
                                        case 'tasbeeh':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return tasbeeh();
                                          }));
                                          break;
                                        case 'listen_naats':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];
                                            String api_url =
                                                allSeasons[index]['api_url'];
                                            print(api_url);
                                            return AudioCategories(
                                                title, api_url);
                                          }));
                                          break;
                                        case 'quran_reciters':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];
                                            String api_url =
                                                allSeasons[index]['api_url'];
                                            return QuranReciters(
                                                title, api_url, true);
                                          }));
                                          break;
                                      }
                                    },
                                    contentPadding: EdgeInsets.all(15),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        allSeasons[index]['title'],
                                        style: GoogleFonts.cairo(
                                            textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16.0,
                                        )),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        allSeasons[index]['description'],
                                        style: GoogleFonts.cairo(
                                            textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 12.0,
                                        )),
                                        maxLines: 2,
                                      ),
                                    ),
                                    leading: Card(
                                      elevation: 15.0,
                                      child: CachedNetworkImage(
                                        width: 80,
                                        height: 80,
                                        imageUrl: allSeasons[index]['img'],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Image.network(
                                          "https://via.placeholder.com/200x150",
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
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
    );
  }
}

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List allSeasons = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FutureBuilder(
            future: getApiResponse(BOOKS_CATEGORY),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  var convertedJson = jsonDecode(snapshot.data.toString());
                  allSeasons = convertedJson['dashboard'];
                  return Container(
                    child: ListView.builder(
                      itemCount: allSeasons.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 1) {
                          return Column(
                            children: [
                              //    showNativeBannerAd(),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                child: Ink(
                                  child: Card(
                                    elevation: 18.0,
                                    child: Container(
                                      child: ListTile(
                                        onTap: () {
                                          showAdmobFullScreenAds();
                                          String type =
                                              allSeasons[index]['type'];
                                          switch (type) {
                                            case 'read_quran':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];

                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];

                                                return ReadQuran(
                                                    title, api_url, true);
                                                //  return MultipleGridView( );
                                              }));
                                              break;
                                            case 'read_books':
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                String title =
                                                    allSeasons[index]['title'];

                                                String api_url =
                                                    allSeasons[index]
                                                        ['api_url'];

                                                return BooksCategories(
                                                    title, api_url);
                                                //  return MultipleGridView( );
                                              }));
                                              break;
                                          }
                                        },
                                        contentPadding: EdgeInsets.all(15),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['title'],
                                            style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
                                              color: AdManager
                                                  .getNeumorphicBackgroundColor(),
                                              fontSize: 16.0,
                                            )),
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            allSeasons[index]['description'],
                                            style: GoogleFonts.cairo(
                                                textStyle: TextStyle(
                                              color: AdManager
                                                  .getNeumorphicBackgroundColor(),
                                              fontSize: 12.0,
                                            )),
                                            maxLines: 2,
                                          ),
                                        ),
                                        leading: Card(
                                          elevation: 15.0,
                                          child: CachedNetworkImage(
                                            width: 80,
                                            height: 80,
                                            imageUrl: allSeasons[index]['img'],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.network(
                                              "https://via.placeholder.com/200x150",
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                            child: Ink(
                              child: Card(
                                elevation: 18.0,
                                child: Container(
                                  child: ListTile(
                                    onTap: () {
                                      showAdmobFullScreenAds();
                                      String type = allSeasons[index]['type'];
                                      switch (type) {
                                        case 'read_quran':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];

                                            String api_url =
                                                allSeasons[index]['api_url'];

                                            return ReadQuran(
                                                title, api_url, true);
                                            //  return MultipleGridView( );
                                          }));
                                          break;
                                        case 'read_books':
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            String title =
                                                allSeasons[index]['title'];

                                            String api_url =
                                                allSeasons[index]['api_url'];

                                            return BooksCategories(
                                                title, api_url);
                                            //  return MultipleGridView( );
                                          }));
                                          break;
                                      }
                                    },
                                    contentPadding: EdgeInsets.all(15),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        allSeasons[index]['title'],
                                        style: GoogleFonts.cairo(
                                            textStyle: TextStyle(
                                          color: AdManager
                                              .getNeumorphicBackgroundColor(),
                                          fontSize: 16.0,
                                        )),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        allSeasons[index]['description'],
                                        style: GoogleFonts.cairo(
                                            textStyle: TextStyle(
                                          color: AdManager
                                              .getNeumorphicBackgroundColor(),
                                          fontSize: 12.0,
                                        )),
                                        maxLines: 2,
                                      ),
                                    ),
                                    leading: Card(
                                      elevation: 15.0,
                                      child: CachedNetworkImage(
                                        width: 80,
                                        height: 80,
                                        imageUrl: allSeasons[index]['img'],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Image.network(
                                          "https://via.placeholder.com/200x150",
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
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
    );
  }
}

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  List allSeasons = [
    {
      'img': 'https://sc04.alicdn.com/kf/UTB87m78DqrFXKJk43Ovq6ybnpXa5.jpg',
      'title': 'Tasbeeh Counter',
      'type': 'tasbeeh',
      'description': 'Please give us 5 Star Ratings. Thanks'
    },
    {
      'img':
          'https://cdn.pixabay.com/photo/2019/11/22/10/02/rate-4644521_1280.png',
      'title': 'Rate Us ',
      'type': 'rate_us',
      'description': 'Please give us 5 Star Ratings. Thanks'
    },
    {
      'img':
          'https://icons-for-free.com/iconfiles/png/512/detail+details+ellipses+more+icon-1320183138163966322.png',
      'title': 'More Apps',
      'type': 'more_apps',
      'description': 'Please checkout our more apps. Thanks'
    },
    {
      'img':
          'https://img.favpng.com/12/3/2/social-media-portable-network-graphics-share-icon-computer-icons-image-png-favpng-5EZ17mi8nFVhDqAE1n7p4G1LA.jpg',
      'title': 'Share This App',
      'type': 'share_app',
      'description': 'Please Share this app with your friends. Thanks'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AdManager.getNeumorphicBackgroundColor(),
        child: Container(
          child: ListView.builder(
            itemCount: allSeasons.length,
            itemBuilder: (BuildContext context, int index) {
              if (index != 0 && index % 3 == 0) {
                return Column(
                  children: [
                    // showNativeBannerAd(),
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
                                String type = allSeasons[index]['type'];
                                goToScreen(type, index);
                              },
                              contentPadding: EdgeInsets.all(15),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 8.0),
                                child: Text(
                                  allSeasons[index]['title'],
                                  style: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                      color: AdManager.getTextColor(),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 8.0),
                                child: Text(
                                  allSeasons[index]['description'],
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                    color: AdManager.getTextColor(),
                                    fontSize: 12.0,
                                  )),
                                  maxLines: 2,
                                ),
                              ),
                              leading: CircleAvatar(
                                child: CachedNetworkImage(
                                  width: 80,
                                  height: 80,
                                  imageUrl: allSeasons[index]['img'],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.network(
                                    "https://via.placeholder.com/200x150",
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
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
                            String type = allSeasons[index]['type'];
                            goToScreen(type, index);
                          },
                          contentPadding: EdgeInsets.all(15),
                          title: Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 8.0),
                            child: Text(
                              allSeasons[index]['title'],
                              style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  color: AdManager.getTextColor(),
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          subtitle: Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 8.0),
                            child: Text(
                              allSeasons[index]['description'],
                              style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                color: AdManager.getTextColor(),
                                fontSize: 12.0,
                              )),
                              maxLines: 2,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: CachedNetworkImage(
                              width: 80,
                              height: 80,
                              imageUrl: allSeasons[index]['img'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.network(
                                "https://via.placeholder.com/200x150",
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
        ),
      ),
    );
  }

  goToScreen(String type, int index) {
    switch (type) {
      case 'tasbeeh':
        showAdmobFullScreenAds();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return tasbeeh();
        }));
        break;
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
              'Please install this best Holy Quran application from App Store and share it with your friends. Thanks\n ' +
                  AdManager.shareUrl,
              subject: 'Look what I made!');
        } else {
          Share.share(
              'Please install this best Holy Quran application from ios App Store and share it with your friends. Thanks\n ' +
                  AdManager.shareUrl,
              subject: 'Look what I made!');
        }

        break;
      case 'find_qibla':
        break;
      case 'islamic_wallpapers':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WallpaperCategories();
        }));
        break;
      case 'read_books':


        break;
      case 'read_quran':


        break;
    }
  }

  _launchURL() async {
    String url =
        'https://apps.apple.com/us/developer/mohammed-alsalak/id1609226760#see-all/i-phonei-pad-apps';
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/developer?id=Bilali';
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
