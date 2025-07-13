import 'package:naat_app/constans.dart';
import 'package:naat_app/pagerDetail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AdManager.dart';
import 'AdManager.dart';
import 'constans.dart';

 
class MultipleGridView extends StatefulWidget {
  String title="Rashid";
 late String bookUrl;
  late String file_name;
  late String ext;
  String totalPages="313";
  MultipleGridView(String title,String bookUrl,String totalPages,String file_name,String ext){
    this.title = title;
    this.bookUrl = bookUrl;
    this.file_name = file_name;
    this.totalPages = totalPages;
    this.ext = ext;
  }
  @override
  _MultipleGridViewState createState() => _MultipleGridViewState();
}

class _MultipleGridViewState extends State<MultipleGridView> {
  @override
  Widget build(BuildContext context) {
    int total = int.parse(widget.totalPages);

    return Scaffold(
      backgroundColor: AdManager.getNeumorphicBackgroundColor(),
      appBar: AppBar(
        backgroundColor: AdManager.getNeumorphicBackgroundColor(),
        title: Center(
          child: Text("Select Page",style: GoogleFonts.cairo(textStyle: TextStyle(
            color: AdManager.getTextColor(),
            fontSize: 22.0,
          )),),
        ),
      ),
      body:  Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),

              itemCount: total,
              itemBuilder: (context, index) {
                int mIndex = index+1;
                return  Card(
                  color: AdManager.getNeumorphicBackgroundColor(),
                  elevation: 16.0,
                  child: ListTile(
                    title: Center(
                      child: Text("$mIndex",style: TextStyle(
                          fontSize: 22.0,
                        color: AdManager.getTextColor(),
                      ),),
                    ),
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        String server = widget.bookUrl;
                        String title = widget.title;
                        String total_pages = widget.totalPages;
                        String file_name = widget.file_name;
                        String ext = widget.ext;
                        int currentPos = index;
                        return MyPageViewOnline(title,server,total_pages,file_name,ext,currentPos);
                        //  return MultipleGridView( );
                      }));
                    },
                  ),
                );
              },
            ),
          ),
          LoadAdmobBannerAds(),
        ],
      ),


    );
  }
}
