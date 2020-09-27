import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:review_app/ui/home_page.dart';

class MyWebview extends StatefulWidget {
  MyWebview(this.title);
  final String title;

  @override
  _MyWebviewState createState() => _MyWebviewState();
}

class _MyWebviewState extends State<MyWebview> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  // StreamSubscription<WebViewStateChanged> _onchanged;
  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _onchanged =
  //       flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
  //         if (mounted) {
  //           if (state.type == WebViewState.finishLoad) {
  //             // if the full website page loaded
  //             print("loaded...");
  //           } else if (state.type == WebViewState.abortLoad) {
  //             // if there is a problem with loading the url
  //             print("there is a problem...");
  //           } else if (state.type == WebViewState.startLoad) {
  //             // if the url started loading
  //             print("start loading...");
  //             return Center(child: CircularProgressIndicator());
  //           }
  //         }
  //       });
  // }

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
        url: widget.title,
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
