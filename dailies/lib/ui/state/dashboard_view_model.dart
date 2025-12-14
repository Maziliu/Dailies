import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  ValueNotifier<int> selectedTabIndex = ValueNotifier(0);

  void selectTab(int index) {
    if (index != selectedTabIndex.value) {
      selectedTabIndex.value = index;
    }
  }
}
