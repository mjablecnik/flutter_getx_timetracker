import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/views/home.dart';

import 'controllers/trackers.dart';


Future<void> main() async {

  runApp(
    GetMaterialApp(
      smartManagement: SmartManagement.full,
      //initialRoute: Routes.HOME,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => TrackersController(), fenix: true);
      }),
      home: HomePage(),

      getPages: [
        GetPage(name: Routes.HOME, page: () => HomePage()),
      ]),
  );
}
