import 'package:dailies_v2/ui/state/dashboard_view_model.dart';
import 'package:dailies_v2/ui/state/init.dart';
import 'package:dailies_v2/ui/views/calendar/calendar_view.dart';
import 'package:dailies_v2/ui/views/overview/overview_view.dart';
import 'package:dailies_v2/ui/views/upload/upload_view.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final PageController _pageController;
  final DashboardViewModel viewModel = DASHBOARD_VIEW_MODEL;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    viewModel.selectTab(index);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        right: false,
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: const [OverviewView(), CalendarView(), UploadView()],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: viewModel.selectedTabIndex,
        builder: (_, index, _) {
          return DashboardNavigationBar(
            currentIndex: index,
            colorScheme: colorScheme,
            onTap: (index) {
              viewModel.selectTab(index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          );
        },
      ),
    );
  }
}

class DashboardNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final ColorScheme colorScheme;

  const DashboardNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.colorScheme,
  });

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
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded, size: 24),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded, size: 24),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload_outlined, size: 24),
            label: 'Upload',
          ),
        ],
      ),
    );
  }
}
