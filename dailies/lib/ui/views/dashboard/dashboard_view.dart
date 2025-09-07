import 'dart:async';
import 'package:dailies/common/utils/ui_helpers.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/global_error_service.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:dailies/ui/views/calendar/calendar_view.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/overview/overview_page_view_model.dart';
import 'package:dailies/ui/views/overview/overview_view.dart';
import 'package:dailies/ui/views/upload/upload_view.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:flutter/material.dart';
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
    _errorSubscription = injector<GlobalErrorService>().errorStream.listen(_onError);
  }

  @override
  void dispose() {
    _errorSubscription.cancel();
    super.dispose();
  }

  void _onError(Exception exception) {
    showErrorSnackbar(message: exception.toString());
  }

  List<Widget> _getViews() {
    return [
      ChangeNotifierProvider.value(value: injector<OverviewPageViewModel>(), child: const OverviewView()),
      ChangeNotifierProvider.value(value: injector<CalendarPageViewModel>(), child: const CalendarView()),
      ChangeNotifierProvider.value(value: injector<UploadViewModel>(), child: const UploadView()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Consumer<DashboardViewModel>(
          builder: (context, viewModel, child) {
            final views = _getViews();

            return IndexedStack(index: viewModel.selectedTabIndex, children: views);
          },
        ),
      ),
      bottomNavigationBar: Consumer<DashboardViewModel>(
        builder: (context, viewModel, _) {
          return DashboardNavigationBar(currentIndex: viewModel.selectedTabIndex, onTap: viewModel.updateSelectedTab, colorScheme: colorScheme);
        },
      ),
    );
  }
}

class DashboardNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final ColorScheme colorScheme;

  const DashboardNavigationBar({super.key, required this.currentIndex, required this.onTap, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
      child: BottomNavigationBar(
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.transparent,
        elevation: 0,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withAlpha(120),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded, size: 24), label: 'Overview'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded, size: 24), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.file_upload_outlined, size: 24), label: 'Upload'),
        ],
      ),
    );
  }
}
