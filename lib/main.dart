import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/controllers/basic.dart';
import 'package:timetracker/controllers/dialog.dart';
import 'package:timetracker/pages/home.dart';
import 'package:timetracker/pages/other.dart';


Future<void> main() async {

  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      initialRoute: Routes.HOME,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BasicController(), fenix: true);
        Get.create(() => DialogController());
      }),
      getPages: [
        GetPage(name: Routes.HOME, page: () => Home()),
        GetPage(name: Routes.OTHER, page: () => Other()),
      ]),
  );
}
