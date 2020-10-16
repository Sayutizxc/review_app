import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/controllers/review_controller.dart';
import 'package:review_app/controllers/tag_controller.dart';
import 'package:review_app/models/review_model.dart';
import 'package:review_app/widgets/custom_form_widget.dart';
import 'package:review_app/widgets/selected_comic.dart';
import 'package:review_app/widgets/selected_tag.dart';

// ignore: must_be_immutable
class InputPage extends StatelessWidget {
  TagsController tagsController = Get.put(TagsController());
  InputPage({this.index});
  int index;
  var typeSelected = "".obs;
  RxList<dynamic> tagSelected = [].obs;
  List<String> select = ["Manga", "Manhua", "Manhwa", "Other"];
  final ReviewController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var isArtValid = true.obs;
    var isStoryValid = true.obs;
    String title = "";
    String review = "";
    double art = 0;
    double story = 0;
    String link = "";

    if (!this.index.isNull) {
      title = controller.reviews[index].title;
      review = controller.reviews[index].deskripsi;
      art = controller.reviews[index].artRating;
      story = controller.reviews[index].storyRating;
      link = controller.reviews[index].link;
      typeSelected.value = controller.reviews[index].comic;
      tagsController.tags.addAllIf(
          !tagsController.tags.contains(controller.reviews[index].tag),
          controller.reviews[index].tag.map<String>((e) => e));
      tagsController.tags = tagsController.tags.toSet().toList().obs;
      tagSelected.addAll(controller.reviews[index].tag);
    }
    TextEditingController titleController = TextEditingController(text: title);

    TextEditingController tagController = TextEditingController();
    TextEditingController reviewController =
        TextEditingController(text: review);
    TextEditingController artRatingController =
        TextEditingController(text: (art == 0.0) ? "" : art.toString());
    TextEditingController storyRatingController =
        TextEditingController(text: (story == 0.0) ? "" : story.toString());
    TextEditingController linkController = TextEditingController(text: link);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'My Review',
                    style: TextStyle(fontFamily: 'Cookie', fontSize: 48),
                  ),
                ),
              ),
              CustomFormField(
                title: 'Title',
                controller: titleController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 20),
              CustomFormField(
                  title: 'Personal Opinion',
                  controller: reviewController,
                  minLines: 8,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(
                      () => CustomFormField(
                        title: 'Art Rating',
                        controller: artRatingController,
                        keyboardType: TextInputType.number,
                        onChanged: (art) {
                          if (int.parse(art) >= 0 && int.parse(art) <= 10) {
                            isArtValid.value = true;
                          } else {
                            isArtValid.value = false;
                            if (!Get.isSnackbarOpen) {
                              Get.snackbar(
                                "Nilai tidak valid",
                                "Cukup berikan nilai 0 - 10",
                                barBlur: 100,
                                colorText: Colors.white,
                                dismissDirection:
                                    SnackDismissDirection.HORIZONTAL,
                                duration: Duration(seconds: 3),
                                margin: EdgeInsets.only(
                                    top: 10, left: 16, right: 16),
                              );
                            }
                          }
                        },
                        suffixIcon: (isArtValid.value)
                            ? null
                            : Icon(Icons.error, color: Colors.red),
                        suffixText: '/ 10',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => CustomFormField(
                          title: 'Story Rating',
                          controller: storyRatingController,
                          keyboardType: TextInputType.number,
                          onChanged: (story) {
                            if (int.parse(story) >= 0 &&
                                int.parse(story) <= 10) {
                              isStoryValid.value = true;
                            } else {
                              isStoryValid.value = false;
                              if (!Get.isSnackbarOpen) {
                                Get.snackbar(
                                  "Nilai tidak valid",
                                  "Cukup berikan nilai 0 - 10",
                                  barBlur: 100,
                                  colorText: Colors.white,
                                  dismissDirection:
                                      SnackDismissDirection.HORIZONTAL,
                                  duration: Duration(seconds: 3),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 16, right: 16),
                                );
                              }
                            }
                          },
                          suffixIcon: (isStoryValid.value)
                              ? null
                              : Icon(Icons.error, color: Colors.red),
                          suffixText: '/ 10'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomFormField(
                title: 'Source [Optional]',
                hintText: 'https://tapas.io/series/the-poem-of-aster-and-hana',
                controller: linkController,
                keyboardType: TextInputType.text,
              ),
              ExpansionTileCard(
                elevation: 0,
                initialElevation: 0,
                //baseColor: ,
                expandedColor: Get.theme.canvasColor,
                shadowColor: Colors.white.withOpacity(0.5),
                title: Text('Advanced Review'),
                children: [
                  Obx(
                    () => Wrap(
                      children: [
                        Wrap(
                          children: select
                              .map(
                                (e) => SelectComic(
                                  text: e,
                                  isSelected: typeSelected.value == e,
                                  onTap: () {
                                    typeSelected.value = e;
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        Wrap(
                          children: tagsController.tags
                              .map(
                                (tagValue) => SelectTag(
                                  text: tagValue,
                                  onDelete: () {
                                    tagsController.tags.remove(tagValue);
                                  },
                                  isSelected: tagSelected.contains(tagValue),
                                  onTap: () {
                                    if (tagSelected.contains(tagValue)) {
                                      tagSelected.remove(tagValue);
                                    } else {
                                      tagSelected.add(tagValue);
                                    }
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomFormField(
                    controller: tagController,
                    title: "Add New Tags",
                    hintText: "Action, Comedy, Fantasy, Etc",
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (!tagsController.tags
                              .contains(tagController.text)) {
                            tagsController.tags.add(tagController.text);
                          }
                          tagController.clear();
                        }),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: RaisedButton(
                  padding: EdgeInsets.all(16),
                  color: Colors.green,
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty &&
                        reviewController.text.trim().isNotEmpty &&
                        artRatingController.text.trim().isNotEmpty &&
                        storyRatingController.text.trim().isNotEmpty &&
                        double.parse(artRatingController.text) >= 0 &&
                        double.parse(storyRatingController.text) >= 0 &&
                        double.parse(artRatingController.text) <= 10 &&
                        double.parse(storyRatingController.text) <= 10) {
                      if (!this.index.isNull) {
                        var editing = controller.reviews[index];
                        editing.title = titleController.text.trim();
                        editing.deskripsi = reviewController.text.trim();
                        editing.comic = typeSelected.value.trim();
                        editing.tag = tagSelected.toList();
                        editing.artRating =
                            double.parse(artRatingController.text);
                        editing.storyRating =
                            double.parse(storyRatingController.text);
                        if (linkController.text.trim().isNotEmpty &&
                            (!linkController.text.trim().contains("https://") ||
                                !linkController.text
                                    .trim()
                                    .contains("https://"))) {
                          linkController.text =
                              "https://" + linkController.text.trim();
                        }
                        editing.link = linkController.text.trim();
                        controller.reviews[index] = editing;
                        Get.back();
                      } else if (this.index.isNull) {
                        if (linkController.text.trim().isNotEmpty &&
                            (!linkController.text.trim().contains("https://") ||
                                !linkController.text
                                    .trim()
                                    .contains("https://"))) {
                          linkController.text =
                              "https://" + linkController.text.trim();
                        }
                        controller.reviews.add(ReviewModel(
                            title: titleController.text.trim(),
                            deskripsi: reviewController.text.trim(),
                            tag: tagSelected,
                            comic: typeSelected.value.trim(),
                            artRating: double.parse(artRatingController.text),
                            storyRating:
                                double.parse(storyRatingController.text),
                            link: linkController.text.trim()));
                        Get.back();
                      }
                    } else {
                      if (!Get.isSnackbarOpen) {
                        Get.snackbar(
                          "Gagal Menyimpan !!",
                          "Pastikan semua kolom sudah diisi dengan sesuai",
                          barBlur: 100,
                          colorText: Colors.white,
                          dismissDirection: SnackDismissDirection.HORIZONTAL,
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                        );
                      }
                    }
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white),
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
