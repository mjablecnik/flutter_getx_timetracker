import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timetracker/constants.dart';
import 'package:timetracker/data/repositories/tracker.dart';
import 'package:timetracker/data/tables/action.dart';
import 'package:timetracker/data/tables/tracker.dart';
import 'package:timetracker/views/home.dart';

import 'controllers/dialog.dart';
import 'controllers/tracker_list.dart';
import 'data/entity_mapper.dart';
import 'data/repositories/action.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'tracker.db');

  //await deleteDatabase(path);

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Database db = await openDatabase(
    path,
    version: 4,
    onCreate: (Database db, int version) async {
      var batch = db.batch();
      batch.execute(TrackerTable.createQuery);
      batch.execute(ActionTable.createQuery);
      await batch.commit();
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      if (oldVersion <= 1) {
        batch.execute(TrackerTable.addElapsedTimeColumnQuery);
      }
      if (oldVersion <= 2) {
        batch.execute(TrackerTable.addInProgressColumnQuery);
      }
      if (oldVersion <= 3) {
        batch.execute(ActionTable.createQuery);
      }
      await batch.commit();
    },
  );


  await GetStorage.init();

  runApp(
    GetMaterialApp(
        smartManagement: SmartManagement.full,
        //initialRoute: Routes.HOME,
        initialBinding: BindingsBuilder(() {
          Get.lazyPut(() => TrackerRepository(db, EntityMapper()), fenix: true);
          Get.lazyPut(() => ActionRepository(db, EntityMapper()), fenix: true);
          Get.lazyPut(() => TrackerListController(), fenix: true);
          Get.lazyPut(() => DialogController(), fenix: true);
        }),
        home: HomePage(),
        getPages: [
          GetPage(name: Routes.HOME, page: () => HomePage()),
        ]),
  );
}
