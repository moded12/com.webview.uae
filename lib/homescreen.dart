import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';


class HomeScreenInAppPurchase extends StatefulWidget {
  @override
  _HomeScreenInAppPurchaseState createState() =>
      _HomeScreenInAppPurchaseState();
}

class _HomeScreenInAppPurchaseState extends State<HomeScreenInAppPurchase> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("In App Purchase"),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey.withOpacity(0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
