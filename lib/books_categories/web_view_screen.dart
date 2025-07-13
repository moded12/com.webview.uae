import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
 import 'package:naat_app/AdManager.dart';
import 'package:naat_app/Model/AllApps.dart';
import 'package:naat_app/apiConstants.dart';
import 'package:naat_app/constans.dart';
import 'package:path_provider/path_provider.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
//import 'package:save_in_gallery/save_in_gallery.dart';
//import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class WebViewScreen extends StatefulWidget {
  List<AppsList> allSeasons = [];
 late String title;
  bool isFirst = true;
  int currentIndex=0;
  WebViewScreen(String title, List<AppsList> allSeasons){
    this.title = title;
    this.allSeasons = allSeasons;
  }

  @override
  State<StatefulWidget> createState() {
    return WebViewScreenState();
  }
}

class WebViewScreenState extends State<WebViewScreen> {

  bool _isAdLoaded = false;
 // final flutterWebViewPlugin = FlutterWebviewPlugin();
  int _pageIndex = 0;
  PageController _pageController =
  PageController(viewportFraction: 1, keepPage: true);
  bool _isLoading = false;
  // final _imageSaver = ImageSaver();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 1, keepPage: true, initialPage: 0);
    widget.currentIndex = 0;
    _pageController.addListener(() {
      setState(() {
        widget.currentIndex = _pageController.page!.toInt();
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    _pageController = PageController(
        viewportFraction: 1, keepPage: true, initialPage: 0);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [
              PageView.builder(
                reverse: true,
                controller: _pageController,
                itemBuilder: (context, position) {
                  int mPos = position;
                  String imgUrl = IMG_BASE_URL + widget.allSeasons[position].server;
                  widget.currentIndex = position;
                  return showImage(imgUrl, mPos);
                },
                itemCount: widget.allSeasons.length,
                onPageChanged: (int i) {
                  setState(() {
                    _pageIndex = int.parse(i.toString());
                  });
                },
              ),
              /* PhotoViewGallery.builder(

                        builder: (BuildContext context, int index) {
                          widget.currentIndex = index;
                          return PhotoViewGalleryPageOptions(
                              minScale: PhotoViewComputedScale.contained,
                              imageProvider: NetworkImage(
                                  IMG_BASE_URL + widget.allSeasons[index].server),
                              heroAttributes: PhotoViewHeroAttributes(
                                  tag: widget.allSeasons[index].server));
                        },
                        itemCount: widget.allSeasons.length,
                        backgroundDecoration: BoxDecoration(color: Colors.white),
                        pageController: _pageController,
                        loadingBuilder: (context, event) => Center(
                          child: Container(
                            child: CircularProgressIndicator(
                              value: event == null
                                  ? 0
                                  : event.cumulativeBytesLoaded /
                                      event.expectedTotalBytes,
                            ),
                          ),
                        ),
                        reverse: true,
                        onPageChanged: (int i) {
                          setState(() {
                            _pageIndex = double.parse(i.toString());
                          });
                        },
                      )  ,*/
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: DotsIndicator(
                    dotsCount: widget.allSeasons.length,
                    axis: Axis.horizontal,
                    position: _pageIndex,
                    reversed: true,
                    // onTap: (position) {
                    //   setState(() {
                    //     _pageIndex = position;
                    //   });
                    // },
                    decorator: DotsDecorator(
                      spacing: const EdgeInsets.all(7.0),
                    ),
                  ),
                ),
              ),

            ]),
          ),
          LoadAdmobBannerAds(),

        ],
      ),
      bottomNavigationBar: Container(
        color: AdManager.getNeumorphicBackgroundColor(),
        child: Platform.isAndroid
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: AdManager.getTextColor(),
                    ),
                    onPressed: () {
                      if (_pageController != null) {
                        int currentPos = _pageController.page!.toInt();
                        currentPos++;
                        changePageViewPostion(currentPos);
                      }
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.share,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      _shareImage(widget.currentIndex);
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.wallpaper,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      setWallPaper(widget.currentIndex);
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.image_search,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      _displayTextInputDialog(context);
                    }),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.arrow_forward_outlined,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      if (_pageController != null) {
                        int currentPos = _pageController.page!.toInt();

                        if (currentPos > 0) {
                          currentPos--;
                        } else {
                          currentPos = 0;
                        }
                        changePageViewPostion(currentPos);
                      }
                    }),
              ),
            )
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: AdManager.getTextColor(),
                    ),
                    onPressed: () {
                      if (_pageController != null) {
                        int currentPos = _pageController.page!.toInt();
                        currentPos++;
                        changePageViewPostion(currentPos);
                      }
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.share,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      _shareImage(widget.currentIndex);
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.image_search,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      _displayTextInputDialog(context);
                    }),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.arrow_forward_outlined,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      if (_pageController != null) {
                        int currentPos = _pageController.page!.toInt();

                        if (currentPos > 0) {
                          currentPos--;
                        } else {
                          currentPos = 0;
                        }
                        changePageViewPostion(currentPos);
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*Future<void> saveAssetImage(int index) async {
    _startLoading();
    if (_pageController != null) {
      int mPage = _pageController.page!.toInt();
      mPage++;

      String url = IMG_BASE_URL + widget.allSeasons[index].server;
      final extension = p.extension(url); // '.dart'
      int timeStamp = DateTime.now().millisecondsSinceEpoch;
      var imageId = await ImageDownloader.downloadImage(url,
          destination: AndroidDestinationType.custom(
              directory: "Pictures/" + AdManager.appName,
              inPublicDir: true,
              subDirectory: '/image$timeStamp' + extension));
      if (imageId != null) {
        Fluttertoast.showToast(
            msg: "Successfully Downloaded",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
*/
  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _shareImage(int index) async {
    try {
      if (_pageController != null) {
        int mPage = _pageController.page!.toInt();
        mPage++;
        String url = IMG_BASE_URL + widget.allSeasons[index].server;
        final extension = p.extension(url); // '.dart'
        var request = await HttpClient().getUrl(Uri.parse(url));
        var response = await request.close();
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    //    final bool isIpad = await _isIpad();
        //  ByteData bytes = await rootBundle.load('assets/wisecrab.png');
        await WcFlutterShare.share(
            sharePopupTitle: AdManager.appName,
            subject: "Best Application",
            text: 'Please download this Imazing app: '+AdManager.shareUrl,
            fileName: 'page$mPage'+extension,
            mimeType: 'image/'+extension,
            bytesOfFile: bytes.buffer.asUint8List(),
            iPadConfig: IPadConfig(
              originX: 0,
              originY: 0,
              originHeight: 0,
              originWidth: 0,
            ));
      }
    } catch (e) {
      print('error: $e');
    }
  }

  /* _isIpad() async {

    if (Platform.isAndroid) {
      return false;
    } else if (Platform.isIOS) {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      return iosInfo.name.toLowerCase().contains('ipad');
    }

  }
*/
  Future<void> setWallPaper(int index) async {
    try {
      /*  if (_pageController != null) {
        int mPage = _pageController.page.toInt();
        mPage++;
        String url = IMG_BASE_URL + widget.allSeasons[index].server;
        final extension = p.extension(url); // '.dart'

        var rng = new Random(); // get temporary directory of device.
        Directory tempDir =
        await getTemporaryDirectory(); // get temporary path from temporary directory.
        String tempPath = tempDir
            .path; // create a new file in temporary path with random file name.
        File file = new File('$tempPath' +
            (rng.nextInt(100)).toString() +
            extension); // call http.get method and pass imageUrl into it to get response.
        http.Response response = await http
            .get(Uri.parse(url)); // write bodyBytes received in response to file.
        await file.writeAsBytes(response
            .bodyBytes); // now return the file which is created with random name in

        int location = WallpaperManager
            .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
        String result;
        result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
        Fluttertoast.showToast(msg: "" + result);
      }*/
    } catch (e) {
      print('error: $e');
    }
  }


  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController _textEditingController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Go To Page'),
            content: TextField(
              decoration:
              new InputDecoration(labelText: "Enter your page number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              // Only numbers can be entered
              onChanged: (value) {
                setState(() {
                  //    widget.currentPos = value as int;
                });
              },
              controller: _textEditingController,
            ),
            actions: <Widget>[
              TextButton(

                child: Text('OK'),
                onPressed: () {
                  String value = _textEditingController.text;
                  if (value != null && !value.isEmpty) {
                    setState(() {
                      widget.currentIndex = int.parse(value);
                      changePageViewPostion(widget.currentIndex);
                      Navigator.pop(context);
                    });
                  }
                },
              ),
              TextButton(

                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void changePageViewPostion(int whichPage) {
    if (_pageController != null) {
      int totalPages = widget.allSeasons.length;
      if (whichPage <= totalPages) {
        _pageController.jumpToPage(whichPage);
      } else {}
    }
  }
  Widget showImage(String imgUrl, int mPos) {
    widget.isFirst = false;

    mPos = mPos + 1;
    String img = imgUrl;
    if (mPos % 7 == 0) {
      showAdmobFullScreenAds();
    }
    return PhotoView(
      backgroundDecoration: BoxDecoration(color: Colors.white),
      imageProvider: CachedNetworkImageProvider(
        img,
      ),
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(
          ),
        ),
      ),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.covered,
    );
    /* return Container(
        child: Image.network(imgUrl+"$mPos"+widget.ext,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        ) );*/
  }
}
