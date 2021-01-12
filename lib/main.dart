import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/data/repositories/tracker.dart';
import 'package:timetracker/data/tables/tracker.dart';
import 'package:timetracker/views/home.dart';

import 'controllers/dialog.dart';
import 'controllers/tracker_list.dart';
import 'data/entity_mapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'tracker.db');

  //await deleteDatabase(path);

  Database db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(TrackerTable.createQuery);
    },
  );


  await GetStorage.init();

  runApp(
    GetMaterialApp(
        smartManagement: SmartManagement.full,
        //initialRoute: Routes.HOME,
        initialBinding: BindingsBuilder(() {
          Get.lazyPut(() => TrackerRepository(db, EntityMapper()), fenix: true);
          Get.lazyPut(() => TrackerListController(), fenix: true);
          Get.lazyPut(() => DialogController(), fenix: true);
        }),
        home: HomePage(),
        getPages: [
          GetPage(name: Routes.HOME, page: () => HomePage()),
        ]),
  );
}
