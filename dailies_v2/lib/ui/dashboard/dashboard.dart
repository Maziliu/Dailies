import 'package:dailies_v2/state/dashboard_view_model.dart';
import 'package:dailies_v2/state/init.dart';
import 'package:dailies_v2/ui/views/calendar_view.dart';
import 'package:dailies_v2/ui/views/overview_view.dart';
import 'package:dailies_v2/ui/views/upload_view.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PageController _pageController;

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

  void _onPageChanged(int index, DashboardViewModel viewModel) {
    if (viewModel.selectedTabIndex != index) {
      viewModel.updateSelectedTab(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel viewModel = DASHBOARD_VIEW_MODEL;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        right: false,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => _onPageChanged(index, viewModel),
          children: const [OverviewView(), CalendarView(), UploadView()],
        ),
      ),
      bottomNavigationBar: DashboardNavigationBar(
        currentIndex: viewModel.selectedTabIndex,
        onTap: (index) {
          viewModel.updateSelectedTab(index);

          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );

          // Explicit rebuild
          setState(() {});
        },
        colorScheme: Theme.of(context).colorScheme,
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
