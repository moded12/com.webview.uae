import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:naat_app/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdManager {

  static getNeumorphicBoxShadowColorLight(){
    return Color(0xFFd5353c);
  }
  static getNeumorphicBoxShadowColorDark(){
    return Color(0xff9d272c);
  }
  static getNeumorphicBackgroundColor(){
    return Color(0xFFb92e34);
  }
  static   getTextColor(){
    return Colors.white;
  }

  static String get baseURL {
    if (Platform.isAndroid) {
      return APP_BASE_URL;
    } else if (Platform.isIOS) {
      return APP_BASE_URL;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get shareUrl {
    if (Platform.isAndroid) {
      return "https://play.google.com/store/apps/details?id="+packageName;
    } else if (Platform.isIOS) {
      return "https://apps.apple.com/app/id"+packageName;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get appName {
    if (Platform.isAndroid) {
      return "معلم الامارات الالكتروني";
    } else if (Platform.isIOS) {
      return "معلم الامارات الالكتروني";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get packageName {
    if (Platform.isAndroid) {
      return "com.webview.uae";
    } else if (Platform.isIOS) {
      return "6444081901";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get moreBooksApiUrl {
    if (Platform.isAndroid) {
      return "https://example.com/apps/api/bilali/more_books_api.json";
    } else if (Platform.isIOS) {
      return "https://example.com/apps/api/bilali/more_books_api.json";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get emailId {
    if (Platform.isAndroid) {
      return "mohmdahmad1968@gmail.com";
    } else if (Platform.isIOS) {
      return "mohmdahmad1968@icloud.com";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8177765238464378~3410500502";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8177765238464378~7443494996";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get appOpenId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8177765238464378/1008309508";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8177765238464378/7177256327";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8177765238464378/8979293430";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8177765238464378/7377429276";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {

      return "ca-app-pub-8177765238464378/4712745364";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8177765238464378/3984979179";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


}