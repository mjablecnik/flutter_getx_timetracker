import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/models/tracker.dart';
import 'package:timetracker/repositories/tracker.dart';
import 'package:timetracker/tables/tracker.dart';
import 'package:timetracker/views/home.dart';

import 'controllers/dialog.dart';
import 'controllers/tracker.dart';
import 'controllers/trackers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'tracker.db');

  //await deleteDatabase(path);

  var db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(TrackerTable.createQuery);
    },
  );

  runApp(
    GetMaterialApp(
        smartManagement: SmartManagement.full,
        //initialRoute: Routes.HOME,
        initialBinding: BindingsBuilder(() {
          Get.lazyPut(() => TrackerRepository(db), fenix: true);
          Get.lazyPut(() => TrackerListController(), fenix: true);
          Get.lazyPut(() => DialogController(), fenix: true);
          Get.lazyPut(() => ScrollController(), fenix: true);
        }),
        home: HomePage(),
        getPages: [
          GetPage(name: Routes.HOME, page: () => HomePage()),
        ]),
  );
}
