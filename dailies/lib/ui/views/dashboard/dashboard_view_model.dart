// dashboard_view_model.dart
import 'package:flutter/foundation.dart';

class DashboardViewModel extends ChangeNotifier {
  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  void updateSelectedTab(int index) {
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }
}
