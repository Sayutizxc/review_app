import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:review_app/ui/home_page.dart';

class MyWebview extends StatefulWidget {
  MyWebview(this.link);
  final String link;

  @override
  _MyWebviewState createState() => _MyWebviewState();
}

class _MyWebviewState extends State<MyWebview> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await flutterWebviewPlugin.cleanCookies();
        await flutterWebviewPlugin.clearCache();
        Get.offAll(HomePage());
        return;
      },
      child: WebviewScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Tempat Baca',
            style: TextStyle(fontFamily: 'Cookie', fontSize: 32),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  flutterWebviewPlugin.goBack();
                }),
            SizedBox(width: 10),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  flutterWebviewPlugin.reload();
                }),
            SizedBox(width: 10),
            IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  flutterWebviewPlugin.goForward();
                }),
            SizedBox(width: 10),
          ],
        ),
        url: widget.link,
        appCacheEnabled: true,
        clearCache: true,
        clearCookies: true,
        supportMultipleWindows: true,
        mediaPlaybackRequiresUserGesture: true,
        withZoom: true,
        hidden: true,
        withJavascript: true,
      ),
    );
  }
}
