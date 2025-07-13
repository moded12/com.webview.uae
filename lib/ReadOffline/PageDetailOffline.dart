import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naat_app/AdManager.dart';
import 'package:naat_app/constans.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
//import 'package:save_in_gallery/save_in_gallery.dart';
//import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import '../AdManager.dart';


class MyPageViewOffline extends StatefulWidget {
  String title="Rashid";
 late String bookUrl;
  late String file_name;
  late String ext;
  String totalPages="313";
  late  int currentPos;
  bool isFirst = true;
  MyPageViewOffline(String title,String bookUrl,String totalPages,String file_name,String ext,int currentPos){
    this.title = title;
    this.bookUrl = bookUrl;
    this.totalPages = totalPages;
    this.file_name = file_name;
    this.ext = ext;
    this.currentPos = currentPos;
  }




  @override
  _MyPageViewOfflineState createState() => _MyPageViewOfflineState();
}

class _MyPageViewOfflineState extends State<MyPageViewOffline> {
 // final _imageSaver = ImageSaver();
  PageController _pageController = PageController(viewportFraction: 1, keepPage: true);
  bool _isLoading = false;
  bool _showResult = false;
  var currentPageValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController!.addListener(() {
      setState(() {
        currentPageValue = _pageController.page!;
      });});
  }

  @override
  Widget build(BuildContext context) {
    var mItemCount = int.parse(widget.totalPages);
    _pageController = PageController(viewportFraction: 1, keepPage: true,initialPage: widget.currentPos);
    String imgUrl = widget.bookUrl+""+widget.file_name+"";
    return Scaffold(
      appBar: AppBar(

        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(
          child: Text(AdManager.appName,style: GoogleFonts.cairo(textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          )),),
        ),
      ),
      body: PageView.builder(

        reverse: true,
        controller: _pageController,
        itemBuilder: (context, position) {
          int mPos = position;

          return showImage(imgUrl,mPos);
        },

        itemCount: mItemCount,
      ),
      bottomNavigationBar: Container(
        color: AdManager.getNeumorphicBackgroundColor(),
        child:  Platform.isAndroid ? Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.arrow_back_outlined,color: AdManager.getTextColor(),), onPressed: (){
                  if(_pageController!=null){
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
                child: IconButton(icon: Icon(Icons.share,color: AdManager.getTextColor()), onPressed: (){
                  _shareImage();
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.wallpaper,color: AdManager.getTextColor()), onPressed: (){
                  setWallPaper();
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.image_search,color: AdManager.getTextColor()), onPressed: (){
                  _displayTextInputDialog(context);
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.download_rounded,color: AdManager.getTextColor()), onPressed: (){
                  saveAssetImage();
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.arrow_forward_outlined,color: AdManager.getTextColor()), onPressed: (){
                  if(_pageController!=null){
                    int currentPos = _pageController.page!.toInt();

                    if(currentPos>0){
                      currentPos--;
                    }else{
                      currentPos=0;
                    }
                    changePageViewPostion(currentPos);
                  }


                }),
              ),
            )
          ],
        ):Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.arrow_back_outlined,color: AdManager.getTextColor(),), onPressed: (){
                  if(_pageController!=null){
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
                child: IconButton(icon: Icon(Icons.share,color: AdManager.getTextColor()), onPressed: (){
                  _shareImage();
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.image_search,color: AdManager.getTextColor()), onPressed: (){
                  _displayTextInputDialog(context);
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.download_rounded,color: AdManager.getTextColor()), onPressed: (){
                  saveAssetImage();
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.arrow_forward_outlined,color: AdManager.getTextColor()), onPressed: (){
                  if(_pageController!=null){
                    int currentPos = _pageController.page!.toInt();

                    if(currentPos>0){
                      currentPos--;
                    }else{
                      currentPos=0;
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

  Widget showImage(String imgUrl,int mPos) {
    widget.isFirst = false;

    mPos=mPos+1;
    String img = "assets/"+imgUrl+"$mPos"+widget.ext;

    if(mPos%7==0){
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
      enableRotation: true,
      backgroundDecoration: BoxDecoration(color: Colors.white),
      imageProvider: AssetImage(img,
      ),



    );
    /* return Container(
        child: Image.network(imgUrl+"$mPos"+widget.ext,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        ) );*/
  }

  Future<void> setWallPaper() async {
    try {
   /*   if(_pageController!=null) {
        int mPage = _pageController.page.toInt();
        mPage++;

        String imgUrl = widget.bookUrl+""+widget.file_name+"";
        String assetPath   = "assets/"+imgUrl+"$mPage"+widget.ext;
        int location = WallpaperManager.HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
        String result;
        result = await WallpaperManager.setWallpaperFromAsset(assetPath, location);
        Fluttertoast.showToast(msg: ""+result);
      }*/
    } catch (e) {
      print('error: $e');
    }
  }
  Future<void> _shareImage() async {
    try {
      if(_pageController!=null) {
        int mPage = _pageController.page!.toInt();
        mPage++;
        String imgUrl = widget.bookUrl+""+widget.file_name+"";
        String assetPath   = "assets/"+imgUrl+"$mPage"+widget.ext;
        final ByteData bytes = await rootBundle.load(assetPath);

        await WcFlutterShare.share(
            sharePopupTitle: AdManager.appName,
            subject: "Best Application",
            text: 'Please download this Imazing app: '+AdManager.shareUrl,
            fileName: 'share.png',
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
  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController _textEditingController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Go To Page'),
            content:    TextField(
              decoration: new InputDecoration(labelText: "Enter your page number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
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
                  if(value!=null&&!value.isEmpty){

                    setState(() {
                      widget.currentPos =  int.parse(value);
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
    if(_pageController != null){
      int totalPages = int.parse(widget.totalPages);
      if(whichPage<=totalPages){
        _pageController.jumpToPage(whichPage);
      }else{

      }
    }

  }
 /* void _saveNetworkImage() async {
    String path =
        'https://image.shutterstock.com/image-photo/montreal-canada-july-11-2019-600w-1450023539.jpg';
    GallerySaver.saveImage(path).then((bool? success) {
      setState(() {
        print('Image is saved');
      });
    });
  }*/
  Future<void> saveAssetImage() async {
    _startLoading();
    if(_pageController!=null){
      int mPage = _pageController.page!.toInt();
      mPage++;

      String imgUrl = widget.bookUrl+""+widget.file_name+"";
      String url   =  "assets/"+imgUrl+"$mPage"+widget.ext;

      final bytes = await rootBundle.load(url);

      int timeStamp = DateTime.now().millisecondsSinceEpoch;
    //  final res = await _imageSaver.saveImage(imageBytes: bytes.buffer.asUint8List(),imageName: '/image$timeStamp',directoryName: AdManager.appName);
      try {
        //extract bytes

        final Uint8List pngBytes = bytes.buffer.asUint8List();

        //create file
        final String dir = (await getApplicationDocumentsDirectory()).path;
        final String fullPath = '$dir/${DateTime.now().millisecond}.png';
        File capturedFile = File(fullPath);
        await capturedFile.writeAsBytes(pngBytes);
        print(capturedFile.path);

        await GallerySaver.saveImage(capturedFile.path).then((value) {
          _stopLoading();
          Fluttertoast.showToast(
              msg: "Successfully Downloaded",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
      } catch (e) {
        print(e);
      }

      // _displayResult(res);
    //  print(res);
    /*  if(res==true){
        Fluttertoast.showToast(
            msg: "Successfully Downloaded",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        Fluttertoast.showToast(
            msg: "Error Occured while downloading",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }*/

    }

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
}
