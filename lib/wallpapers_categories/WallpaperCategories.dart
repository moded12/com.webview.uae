import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class WallpaperCategories extends StatefulWidget {
  @override
  _WallpaperCategoriesState createState() => _WallpaperCategoriesState();
}

class _WallpaperCategoriesState extends State<WallpaperCategories> {
  String _platformVersion = 'Unknown';
  String _wallpaperFile = 'Unknown';
  String _wallpaperFileWithCrop = 'Unknown';
  String _wallpaperAsset = 'Unknown';
  String _wallpaperAssetWithCrop = 'Unknown';

  @override
  void initState() {
    super.initState();
  }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Container()),
    );
  }
}
