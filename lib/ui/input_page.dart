import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/controllers/review_controller.dart';
import 'package:review_app/models/review_model.dart';

// ignore: must_be_immutable
class InputPage extends StatelessWidget {
  InputPage({this.index});
  int index;
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
    }
    TextEditingController titleController = TextEditingController(text: title);
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
                  style: GoogleFonts.cookie(fontSize: 48),
                ),
              ),
            ),
            FormField(
              title: 'Judul',
              controller: titleController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            FormField(
              title: 'Pendapat Pribadi',
              controller: reviewController,
              minLines: 8,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(
                    () => FormField(
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
                              dismissDirection:
                                  SnackDismissDirection.HORIZONTAL,
                              duration: Duration(seconds: 3),
                              margin:
                                  EdgeInsets.only(top: 10, left: 16, right: 16),
                            );
                          }
                        }
                      },
                      suffixIcon: (isArtValid.value)
                          ? null
                          : Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => FormField(
                      title: 'Story Rating',
                      controller: storyRatingController,
                      keyboardType: TextInputType.number,
                      onChanged: (story) {
                        if (int.parse(story) >= 0 && int.parse(story) <= 10) {
                          isStoryValid.value = true;
                        } else {
                          isStoryValid.value = false;
                          if (!Get.isSnackbarOpen) {
                            Get.snackbar(
                              "Nilai tidak valid",
                              "Cukup berikan nilai 0 - 10",
                              barBlur: 100,
                              dismissDirection:
                                  SnackDismissDirection.HORIZONTAL,
                              duration: Duration(seconds: 3),
                              margin:
                                  EdgeInsets.only(top: 10, left: 16, right: 16),
                            );
                          }
                        }
                      },
                      suffixIcon: (isStoryValid.value)
                          ? null
                          : Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            FormField(
              title: 'Tempat Baca',
              hintText:
                  'https://komikcast.com/komik/the-great-mage-returns-after-4000-years/',
              controller: linkController,
              keyboardType: TextInputType.text,
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
                      editing.artRating =
                          double.parse(artRatingController.text);
                      editing.storyRating =
                          double.parse(storyRatingController.text);
                      editing.link = linkController.text;
                      controller.reviews[index] = editing;
                      Get.back();
                    } else if (this.index.isNull) {
                      if (linkController.text.trim().isEmpty)
                        linkController.text = " ";
                      controller.reviews.add(ReviewModel(
                          title: titleController.text.trim(),
                          deskripsi: reviewController.text.trim(),
                          artRating: double.parse(artRatingController.text),
                          storyRating: double.parse(storyRatingController.text),
                          link: linkController.text));
                      Get.back();
                    }
                  } else {
                    if (!Get.isSnackbarOpen) {
                      Get.snackbar(
                        "Gagal Menyimpan !!",
                        "Pastikan semua kolom sudah diisi dengan sesuai",
                        barBlur: 100,
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
    ));
  }
}

class FormField extends StatelessWidget {
  final String title;
  final String hintText;
  final int maxLength;
  final int minLines;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function onChanged;
  final Widget suffixIcon;
  const FormField(
      {this.title,
      this.maxLength,
      this.minLines,
      this.keyboardType,
      this.controller,
      this.onChanged,
      this.suffixIcon,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        autocorrect: false,
        textAlign: TextAlign.justify,
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        maxLines: null,
        minLines: minLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          labelText: title,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 20),
          hoverColor: Colors.blue,
        ),
      ),
    );
  }
}
