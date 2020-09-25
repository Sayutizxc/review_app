import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:review_app/ui/home_page.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.fade,
    home: HomePage(),
  ));
}
