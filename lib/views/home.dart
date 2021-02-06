import 'package:animated_indexed_stack/animated_indexed_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timetracker/controllers/home.dart';
import 'package:timetracker/controllers/tracker_list.dart';
import 'package:timetracker/views/dialog.dart';
import 'package:timetracker/views/history.dart';
import 'package:timetracker/views/review.dart';
import 'package:timetracker/views/tracker_list.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: TrackerListView(),
          icon: Icon(Icons.timelapse),
          title: "Time trackers",
        ),
        TabNavigationItem(
          page: ReviewView(),
          icon: Icon(Icons.list_alt),
          title: "Work review",
        ),
        TabNavigationItem(
          page: HistoryView(),
          icon: Icon(Icons.history),
          title: "History",
        ),
      ];
}

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("TimeTracker"),
          actions: [
            if (controller.index == 0)
              NewTrackerButton()
          ],
        ),
        body: AnimatedIndexedStack(
          transitionBuilder: slideTransition,
          selectedIndex: controller.index,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.index,
          onTap: controller.changeIndex,
          items: [
            for (final tabItem in TabNavigationItem.items)
              BottomNavigationBarItem(
                icon: tabItem.icon,
                label: tabItem.title,
              )
          ],
        ),
      ),
    );
  }
}

class NewTrackerButton extends GetView<TrackerListController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        child: Icon(Icons.add),
        onTap: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TrackerDialog(
                title: "Add new tracker",
                onSubmit: (item) => controller.addItem(item),
              );
            },
          )
        },
      ),
    );
  }
}

final RouteTransitionsBuilder slideTransition = (
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return GetBuilder<HomeController>(
    init: HomeController(),
    builder: (c) {
      Widget appear = SlideTransition(
        position: Tween<Offset>(
          begin: Offset(c.transitionPos.toDouble(), 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );

      Widget disappear = SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: Offset(-c.transitionPos.toDouble(), 0.0),
        ).animate(secondaryAnimation),
        child: appear,
      );

      return disappear;
    },
  );
};
