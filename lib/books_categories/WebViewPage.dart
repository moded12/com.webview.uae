import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naat_app/AdManager.dart';
import 'package:naat_app/books_categories/src/web_view_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';
const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';
class WebViewPage extends StatefulWidget {

 late String title;
 late String server;
    WebViewPage(String title,String server) {
    this.title = title;
    this.server=server;
  }
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
print("PageUrl"+widget.server);
return Scaffold(
  appBar: AppBar(
    backgroundColor: AdManager.getNeumorphicBackgroundColor(),
    title:   Center(child: Text(widget.title,style: GoogleFonts.cairo(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        color: Colors.white
    ),)),
    // This drop down menu demonstrates that Flutter widgets can be shown over the web view.

  ),
  // We're using a Builder here so we have a context that is below the Scaffold
  // to allow calling Scaffold.of(context) so we can show a snackbar.
  body: Builder(builder: (BuildContext context) {
    return WebViewExample(
        widget.server
    //  url: widget.server,
     /* hidden: true,
      withZoom: true,*/

    );
  }),

);
  }


 }


