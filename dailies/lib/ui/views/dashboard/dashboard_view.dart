import 'package:dailies/dependency_setup.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/calendar/calendar_view.dart';
import 'package:dailies/ui/views/calendar/calendar_view_model.dart';
import 'package:dailies/ui/views/overview/overview_view.dart';
import 'package:dailies/ui/views/overview/overview_view_model.dart';
import 'package:dailies/ui/views/upload/upload_view.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: IndexedStack(
            index: viewModel.selectedTabIndex,
            children: [
              ChangeNotifierProvider(create: (_) => injector<OverviewViewModel>(), child: const OverviewView()),
              ChangeNotifierProvider(create: (_) => injector<CalendarViewModel>(), child: const CalendarView()),
              ChangeNotifierProvider(create: (_) => UploadViewModel(), child: const UploadView()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            onTap: viewModel.updateSelectedTab,
            currentIndex: viewModel.selectedTabIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Overview'),
              BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Calendar'),
              BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
            ],
          ),
        );
      },
    );
  }
}
