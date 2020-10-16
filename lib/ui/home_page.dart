import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controllers/review_controller.dart';
import 'package:review_app/ui/input_page.dart';
import 'package:review_app/ui/webview_page.dart';

class HomePage extends StatelessWidget {
  final ReviewController controller = Get.put(ReviewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xfffee715),
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(InputPage(), transition: Transition.cupertino);
          }),
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Review',
            style: TextStyle(fontFamily: 'Cookie', fontSize: 32),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.reviews.length,
          itemBuilder: (_, index) {
            var tags = controller.reviews[index].tag;
            print(tags);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 5,
                          offset: Offset(0, 0),
                          spreadRadius: 2),
                    ], borderRadius: BorderRadius.circular(8.0)),
                    child: ExpansionTileCard(
                      initialElevation: 0,
                      elevation: 0,
                      shadowColor: Colors.black,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Title',
                                ),
                              ),
                              Expanded(
                                child: Text(controller.reviews[index].title,
                                    softWrap: true),
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Type')),
                              Expanded(
                                child: Text(
                                  (controller.reviews[index].comic != "")
                                      ? controller.reviews[index].comic
                                      : "N/A",
                                ),
                              )
                            ],
                          ),
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
                          (!tags.isNullOrBlank)
                              ? Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: tags
                                      .map(
                                        (e) => Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          margin:
                                              EdgeInsets.only(top: 5, right: 5),
                                          child: Text(
                                            e.toString().trim(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Container(),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Divider(),
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
                                      Get.to(MyWebview(
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
