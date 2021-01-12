import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timetracker/views/history.dart';
import 'package:timetracker/views/review.dart';
import 'package:timetracker/views/trackers.dart';

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
      page: TrackersView(),
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