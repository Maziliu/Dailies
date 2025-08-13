import 'package:dailies/dependency_setup.dart';
import 'package:dailies/ui/views/calendar/calendar_page_view_model.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/calendar/calendar_view.dart';
import 'package:dailies/ui/views/overview/overview_view.dart';
import 'package:dailies/ui/views/overview/overview_view_model.dart';
import 'package:dailies/ui/views/upload/upload_view.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
            extendBody: true,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colorScheme.surface, colorScheme.surface],
                  stops: const [0.0, 0.3],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 80),
                  child: IndexedStack(
                    index: viewModel.selectedTabIndex,
                    children: [
                      ChangeNotifierProvider.value(value: injector<OverviewViewModel>(), child: const OverviewView()),
                      ChangeNotifierProvider.value(value: injector<CalendarPageViewModel>(), child: const CalendarView()),
                      ChangeNotifierProvider.value(value: injector<UploadViewModel>(), child: const UploadView()),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 20, offset: const Offset(0, -5))],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                    BottomNavigationBarItem(icon: _buildNavIcon(Icons.dashboard_rounded, 0, viewModel.selectedTabIndex, colorScheme), label: 'Overview'),
                    BottomNavigationBarItem(icon: _buildNavIcon(Icons.calendar_today_rounded, 1, viewModel.selectedTabIndex, colorScheme), label: 'Calendar'),
                    BottomNavigationBarItem(icon: _buildNavIcon(Icons.cloud_upload_rounded, 2, viewModel.selectedTabIndex, colorScheme), label: 'Upload'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavIcon(IconData icon, int index, int selectedIndex, ColorScheme colorScheme) {
    final isSelected = index == selectedIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: isSelected ? colorScheme.primary.withAlpha(30) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, size: 24, color: isSelected ? colorScheme.primary : colorScheme.onSurface.withAlpha(120)),
    );
  }
}
