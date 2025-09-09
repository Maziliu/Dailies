import 'dart:async';
import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/common/utils/ui_helpers.dart';
import 'package:dailies/dependency_setup.dart';
import 'package:dailies/service/global_error_service.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:dailies/ui/views/calendar/calendar_view.dart';
import 'package:dailies/ui/views/dashboard/components/dashboard_navigation_bar.dart';
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _errorSubscription = injector<GlobalErrorService>().errorStream.listen(_onError);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _errorSubscription.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onError(Exception exception) => showErrorSnackbar(message: exception.toString());

  void _onPageChanged(int index, DashboardViewModel viewModel) {
    if (viewModel.selectedTabIndex != index) {
      viewModel.updateSelectedTab(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        right: false,
        child: Consumer<DashboardViewModel>(
          builder: (context, viewModel, child) {
            return PageView(
              controller: _pageController,
              onPageChanged: (index) => _onPageChanged(index, viewModel),
              children: [
                ChangeNotifierProvider.value(value: injector<OverviewPageViewModel>(), child: const OverviewView()),
                ChangeNotifierProvider.value(value: injector<CalendarPageViewModel>(), child: const CalendarView()),
                ChangeNotifierProvider.value(value: injector<UploadViewModel>(), child: const UploadView()),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<DashboardViewModel>(
        builder: (context, viewModel, _) {
          return DashboardNavigationBar(
            currentIndex: viewModel.selectedTabIndex,
            onTap: (index) {
              viewModel.updateSelectedTab(index);
              _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
            colorScheme: context.colorScheme,
          );
        },
      ),
    );
  }
}
