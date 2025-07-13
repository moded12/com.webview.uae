import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naat_app/AdManager.dart';
import 'package:naat_app/constans.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
//import 'package:save_in_gallery/save_in_gallery.dart';
//import 'package:wallpaper_manager/wallpaper_manager.dart';
  import 'package:flutter/widgets.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class MyPageViewOnline extends StatefulWidget {
  String title = "Rashid";
 late String bookUrl;
  late  String file_name;
  late  String ext;
  String totalPages = "313";
 late int currentPos;
  bool isFirst = true;

  MyPageViewOnline(String title, String bookUrl, String totalPages,
      String file_name, String ext, int currentPos) {
    this.title = title;
    this.bookUrl = bookUrl;
    this.totalPages = totalPages;
    this.file_name = file_name;
    this.ext = ext;
    this.currentPos = currentPos;
  }

  @override
  _MyPageViewOnlineState createState() => _MyPageViewOnlineState();
}

class _MyPageViewOnlineState extends State<MyPageViewOnline> {
  var currentPageValue = 0.0;
  bool _isLoading = false;
 // final _imageSaver = ImageSaver();

  PageController _pageController =
  PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mItemCount = int.parse(widget.totalPages);
    String imgUrl = widget.bookUrl + "" + widget.file_name + "";
    _pageController = PageController(
        viewportFraction: 1, keepPage: true, initialPage: widget.currentPos);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                )),
          ),
        ),
      ),
      body: PageView.builder(
        reverse: true,
        controller: _pageController,
        itemBuilder: (context, position) {
          int mPos = position;
          return showImage(imgUrl, mPos);
        },
        itemCount: mItemCount,
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
                      _shareImage();
                    }),
              ),
            ),
            /*Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.wallpaper,
                        color: AdManager.getTextColor()),
                    onPressed: () {
                      setWallPaper();
                    }),
              ),
            ),*/
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
                      _shareImage();
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

  Future<void> _shareImage() async {
    try {
      if (_pageController != null) {
        int mPage = _pageController.page!.toInt();
        mPage++;
        String urls = widget.bookUrl +
            "" +
            widget.file_name +
            "" +
            mPage.toString() +
            widget.ext;
        var request = await HttpClient().getUrl(Uri.parse(urls));
        var response = await request.close();
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);

        //  ByteData bytes = await rootBundle.load('assets/wisecrab.png');
        await WcFlutterShare.share(
            sharePopupTitle: AdManager.appName,
            subject: "Best Application",
            text: 'Please download this Imazing app: '+AdManager.shareUrl,
            fileName: 'page$mPage.png',
            mimeType: 'image/png',
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



  Future<void> setWallPaper() async {
    try {
     /* if (_pageController != null) {
        int mPage = _pageController.page.toInt();
        mPage++;
        String imageUrl = widget.bookUrl +
            "" +
            widget.file_name +
            "" +
            mPage.toString() +
            widget.ext;
        var rng = new Random(); // get temporary directory of device.
        Directory tempDir =
        await getTemporaryDirectory(); // get temporary path from temporary directory.
        String tempPath = tempDir
            .path; // create a new file in temporary path with random file name.
        File file = new File('$tempPath' +
            (rng.nextInt(100)).toString() +
            '.png'); // call http.get method and pass imageUrl into it to get response.
        http.Response response = await http
            .get(Uri.parse(imageUrl)); // write bodyBytes received in response to file.
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

   urlToFile(String imageUrl) async {
    // generate random number.
    var rng = new Random(); // get temporary directory of device.
    Directory tempDir =
    await getTemporaryDirectory(); // get temporary path from temporary directory.
    String tempPath = tempDir
        .path; // create a new file in temporary path with random file name.
    File file = new File('$tempPath' +
        (rng.nextInt(100)).toString() +
        '.png'); // call http.get method and pass imageUrl into it to get response.
    http.Response response = await http
        .get(Uri.parse(imageUrl)); // write bodyBytes received in response to file.
    await file.writeAsBytes(response
        .bodyBytes); // now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.return file;
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
                      widget.currentPos = int.parse(value);
                      changePageViewPostion(widget.currentPos);
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
      int totalPages = int.parse(widget.totalPages);
      if (whichPage <= totalPages) {
        _pageController.jumpToPage(whichPage);
      } else {}
    }
  }

  Widget showImage(String imgUrl, int mPos) {
    widget.isFirst = false;

    mPos = mPos + 1;
    String img = imgUrl + "$mPos" + widget.ext;
    if (mPos % 7 == 0) {
      showAdmobFullScreenAds();
    }
    return PhotoView(
      loadingBuilder: (context, progress) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(

          ),
        ),
      ),
      backgroundDecoration: BoxDecoration(color: Colors.white),
      imageProvider: CachedNetworkImageProvider(
        img,

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
