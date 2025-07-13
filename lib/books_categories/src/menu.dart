import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegate,
  userAgent,
  javascriptChannel,
  listCookies,
  clearCookies,
  addCookie,
  setCookie,
  removeCookie,
}

class Menu extends StatefulWidget {
  Menu(this.controller);

    Completer<WebViewController> controller;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: widget.controller.future,
      builder: (context, controller) {
        return PopupMenuButton<_MenuOptions>(
          onSelected: (value) async {
            switch (value) {
              case _MenuOptions.navigationDelegate:
              //  await controller.data?.loadUrl('https://youtube.com');
                break;
              case _MenuOptions.userAgent:
              //  final userAgent = await controller.data
                //    ?.runJavascriptReturningResult('navigator.userAgent');
                if (!mounted) return;
           //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             //     content: Text(userAgent!),
              //  ));
                break;
              case _MenuOptions.javascriptChannel:

                break;
              case _MenuOptions.clearCookies:
                await _onClearCookies();
                break;
              case _MenuOptions.listCookies:
              //  await _onListCookies(controller.data);
                break;
              case _MenuOptions.addCookie:
             //   await _onAddCookie(controller.data);
                break;
              case _MenuOptions.setCookie:
             //   await _onSetCookie(controller.data);
                break;
              case _MenuOptions.removeCookie:
            //    await _onRemoveCookie(controller.data);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.navigationDelegate,
              child: Text('Navigate to YouTube'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.userAgent,
              child: Text('Show user-agent'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.javascriptChannel,
              child: Text('Lookup IP Address'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.clearCookies,
              child: Text('Clear cookies'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.listCookies,
              child: Text('List cookies'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.addCookie,
              child: Text('Add cookie'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.setCookie,
              child: Text('Set cookie'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.removeCookie,
              child: Text('Remove cookie'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _onClearCookies() async {

  }

  Future<void> _onAddCookie(WebViewController controller) async {

  }

  Future<void> _onSetCookie(WebViewController controller) async {

  }

  Future<void> _onRemoveCookie(WebViewController controller) async {

  }
}
