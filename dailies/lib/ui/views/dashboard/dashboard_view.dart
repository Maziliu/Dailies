import 'dart:async';

import 'package:dailies/common/utils/ui_helpers.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/global_error_service.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/calendar/calendar_view.dart';
import 'package:dailies/ui/views/overview/overview_view.dart';
import 'package:dailies/ui/views/overview/overview_page_view_model.dart';
import 'package:dailies/ui/views/upload/upload_view.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late StreamSubscription<Exception> _errorSubscription;

  @override
  void initState() {
    super.initState();
    _errorSubscription = injector<GloablErrorService>().errorStream.listen(_onError);
  }

  @override
  void dispose() {
    _errorSubscription.cancel();
    super.dispose();
  }

  void _onError(Exception exception) {
    showErrorSnackbar(message: exception.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, viewModel, child) {
        final colorScheme = Theme.of(context).colorScheme;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: colorScheme.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: colorScheme.surface,
            systemNavigationBarIconBrightness: colorScheme.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            body: SafeArea(
              bottom: false,
              child: IndexedStack(
                index: viewModel.selectedTabIndex,
                children: [
                  ChangeNotifierProvider.value(value: injector<OverviewPageViewModel>(), child: const OverviewView()),
                  ChangeNotifierProvider.value(value: injector<CalendarPageViewModel>(), child: const CalendarView()),
                  ChangeNotifierProvider.value(value: injector<UploadViewModel>(), child: const UploadView()),
                ],
              ),
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                onTap: viewModel.updateSelectedTab,
                currentIndex: viewModel.selectedTabIndex,
                selectedItemColor: colorScheme.primary,
                unselectedItemColor: colorScheme.onSurface.withAlpha(120),
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                items: [
                  BottomNavigationBarItem(icon: _buildNavigationWidget(Icons.dashboard_rounded, 0, viewModel.selectedTabIndex, colorScheme), label: 'Overview'),
                  BottomNavigationBarItem(
                    icon: _buildNavigationWidget(Icons.calendar_today_rounded, 1, viewModel.selectedTabIndex, colorScheme),
                    label: 'Calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavigationWidget(Icons.cloud_upload_rounded, 2, viewModel.selectedTabIndex, colorScheme),
                    label: 'Upload',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationWidget(IconData icon, int index, int selectedIndex, ColorScheme colorScheme) {
    final isSelected = index == selectedIndex;

    return Icon(icon, size: 24, color: isSelected ? colorScheme.primary : colorScheme.onSurface.withAlpha(120));
  }
}
