import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/controllers/review_controller.dart';
import 'package:review_app/ui/input_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final ReviewController controller = Get.put(ReviewController());
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(InputPage(), transition: Transition.cupertino);
          }),
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Review',
            style: GoogleFonts.cookie(fontSize: 32),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.reviews.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ExpansionTileCard(
                      elevation: 2,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Title')),
                              Expanded(
                                child: Text(controller.reviews[index].title,
                                    softWrap: true),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Art Rating')),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Text(controller.reviews[index].artRating
                                        .toString())
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Story Rating')),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Text(controller.reviews[index].storyRating
                                        .toString()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Divider(),
                              //Text('My Review'),
                              Text(
                                controller.reviews[index].deskripsi,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              RaisedButton(
                                color: (controller.reviews[index].link.isEmpty)
                                    ? Colors.grey
                                    : controller.reviews[index].link
                                            .substring(
                                                0,
                                                controller.reviews[index].link
                                                        .length -
                                                    2)
                                            .contains(".")
                                        ? Colors.green
                                        : Colors.grey,
                                child: Text(
                                  'Baca disini',
                                  style: TextStyle(color: Colors.white),
                                ),
                                elevation: 0,
                                onPressed: () async {
                                  if (controller
                                      .reviews[index].link.isNotEmpty) {
                                    if (controller.reviews[index].link
                                        .substring(
                                            0,
                                            controller.reviews[index].link
                                                    .length -
                                                2)
                                        .contains(".")) {
                                      // await _launchURL(
                                      //     controller.reviews[index].link);
                                      Get.to(MyWebView(
                                          controller.reviews[index].link));
                                    } else {
                                      Get.defaultDialog(
                                        title: 'Peringatan',
                                        middleText:
                                            'Tidak dapat membuka tautan, pastikan Link yang anda gunakan sudah benar',
                                        confirm: FlatButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('OK'),
                                        ),
                                      );
                                    }
                                  } else {
                                    Get.defaultDialog(
                                      title: 'Peringatan',
                                      middleText:
                                          'Tidak dapat membuka tautan, pastikan Link yang anda gunakan sudah benar',
                                      confirm: FlatButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('OK'),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        Get.to(InputPage(index: index));
                                      }),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'Peringatan',
                                        middleText:
                                            'Apakah anda yakin untuk menghapus ?',
                                        confirm: FlatButton(
                                          onPressed: () {
                                            controller.reviews.removeAt(index);
                                            Get.back();
                                          },
                                          child: Text('Ya'),
                                        ),
                                        cancel: FlatButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('Batal'),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  _launchURL(String link) async {
    final url = link;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}

class MyWebView extends StatefulWidget {
  MyWebView(this.title);
  final String title;

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    print('============== Dispos dipanggil==============');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await flutterWebviewPlugin.cleanCookies();
        await flutterWebviewPlugin.clearCache();
        // flutterWebviewPlugin.dispose();
        print('============== WillPopScope dipanggil==============');
        Get.offAll(HomePage());
        return;
      },
      child: WebviewScaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  await flutterWebviewPlugin.reload();
                  print('refresh');
                }),
          ],
        ),
        url: widget.title,
        appCacheEnabled: false,
        withZoom: true,
        withJavascript: true,
      ),
    );
  }
}
