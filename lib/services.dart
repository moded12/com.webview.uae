import 'dart:convert';

 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:naat_app/main.dart';

/*getApiResponse(String apiUrl) async{
  try{
    if(apiUrl!=null&&apiUrl.isNotEmpty){
      var  mresponse = await http.get(Uri.parse(apiUrl));
      String body = utf8.decode(mresponse.bodyBytes);
      return body;
    }
  }on Exception catch (e) {
      print('Server error occurd '+e.toString());

  }



}*/

getApiResponse(String apiUrl) async{
  try{
    if(apiUrl!=null&&apiUrl.isNotEmpty){


      String? body =  box.get(apiUrl);
      if(body!=null&&body.isNotEmpty){
        updateApiResponse(apiUrl);
        return updateApiResponse(apiUrl);
      //  return body;
      }else{
        return updateApiResponse(apiUrl);
      }

    }
  }on Exception catch (e) {
    print('Server error occurd '+e.toString());

  }



}
updateApiResponse(String apiUrl) async{
  bool result = await InternetConnectionChecker().hasConnection;
  if(result == true) {

  } else {
    Fluttertoast.showToast(
        msg: "انت غير متصل بالانترنت",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    // print(DataConnectionChecker().lastTryResults);
  }
  try{
    if(apiUrl!=null&&apiUrl.isNotEmpty){
    //  print(apiUrl.toString());
      var  mresponse = await http.get(Uri.parse(apiUrl));
      String body = utf8.decode(mresponse.bodyBytes);
      box.put(apiUrl, body);

      return body;
    }
  }on Exception catch (e) {
    print('Server error occurd '+e.toString());

  }



}
