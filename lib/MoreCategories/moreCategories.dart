import 'package:naat_app/pagerDetail.dart';
import 'package:flutter/material.dart';


class moreCategories extends StatelessWidget {
  
  @override  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,

        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            )

            ,
            elevation: 18.0,
            backgroundColor: Color(0xFF000000),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "Listen", icon: Icon(Icons.music_video)),
                Tab(text: "Watch",icon: Icon(Icons.ondemand_video)),
                Tab(text: "Read",icon: Icon(Icons.menu_book_outlined)),
              ],
            ),
            title: Center(child: Text("title")),
          ),
          body: TabBarView(
            children: [
              Container(
                child: Text("Listen"),
              ),
              Container( child: Text("Watch"),),
              Container( child: Text("Read"),),
            ],
          ),
        ),
      ),
    );
  }
}
 