/*
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadRemoteData extends StatefulWidget {
  @override
  _LoadRemoteDataState createState() => _LoadRemoteDataState();
}

class _LoadRemoteDataState extends State<LoadRemoteData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote Config Example',
      home: FutureBuilder<RemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
          return snapshot.hasData
              ? WelcomeWidget(remoteConfig: snapshot.data)
              : Container();
        },
      ),
    );
  }
}


class WelcomeWidget extends AnimatedWidget {
  WelcomeWidget({this.remoteConfig}) : super(listenable: remoteConfig);

  final RemoteConfig remoteConfig;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Config Example'),
      ),
      body: Center(child: Text('Welcome ${remoteConfig.getString('welcome')}')),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () async {
            try {
              // Using default duration to force fetching from remote server.
              await remoteConfig.fetch(expiration: const Duration(seconds: 0));
              await remoteConfig.activateFetched();
            } on FetchThrottledException catch (exception) {
              // Fetch throttled.
              print(exception);
            } catch (exception) {
              print(
                  'Unable to fetch remote config. Cached or default values will be '
                      'used');
            }
          }),
    );
  }
}

Future<RemoteConfig> setupRemoteConfig() async {
  await Firebase.initializeApp();
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Allow a fetch every millisecond. Default is 12 hours.

  remoteConfig
      .setConfigSettings(RemoteConfigSettings());
  try {
    // Using default duration to force fetching from remote server.
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
   String myData = remoteConfig.getString('welcome');
   if(myData!=null&&myData.isNotEmpty){
     setSharedPrefrences("welcome",myData);
   }
  } on FetchThrottledException catch (exception) {
    // Fetch throttled.
    print(exception);
  } catch (exception) {
    print(
        'Unable to fetch remote config. Cached or default values will be '
            'used');
  }
  */
/*remoteConfig.setDefaults(<String, dynamic>{
    'welcome': 'default welcome',
    'hello': 'default hello',
  });*//*

  return remoteConfig;
}

Future<void> setSharedPrefrences(String key,String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(key!=null&&key.isNotEmpty){
    await prefs.setString(key, value);
  }

 }
Future<void> retreiveSharedPrefrences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   String value = prefs.getString('counter');
   if(value!=null&&value.isNotEmpty){
     return value;
   }else{
     return "";
   }

}*/
