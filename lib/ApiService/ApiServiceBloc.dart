import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naat_app/ApiService/ApiServiceEvent.dart';
import 'package:naat_app/ApiService/ApiServiceState.dart';

class ApiServiceBloc extends Bloc<ApiServiceEvent, ApiServiceState> {
 late StreamSubscription _streamSubscription;
 late String apiUrl;
  ApiServiceBloc(String mApiUrl) : super(ApiServiceInitialState()) {
     on<ApiServiceLoadingEvent>((event, emit) => ApiServiceLoadingState());
  this.apiUrl = mApiUrl;
    on<ApiServiceLoadEvent>((event, emit)  async {
        try{
        if(apiUrl!=null&&apiUrl.isNotEmpty){
        print(apiUrl.toString());
        var mresponse = await http.get(Uri.parse(apiUrl));
        String body = utf8.decode(mresponse.bodyBytes);

       // return body;
        emit(ApiServiceLoadedState(body));
        }
        }on Exception catch (e)
    {
      print('Server error occurd '+e.toString());
    }
  }

  );

}

getApiResponse(String apiUrl) async {
  try {
    if (apiUrl != null && apiUrl.isNotEmpty) {
      print(apiUrl.toString());
      var mresponse = await http.get(Uri.parse(apiUrl));
      String body = utf8.decode(mresponse.bodyBytes);

      return body;
    }
  } on Exception catch (e) {
    print('Server error occurd '+e.toString());

  }
}}