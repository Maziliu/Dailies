import 'package:dailies/dependency_injector.dart';
import 'package:dailies/presentation/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/presentation/views/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setUpDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: ChangeNotifierProvider(
        create: (_) => injector<DashboardViewModel>(),
        child: const DashboardView(),
      ),
    );
  }
}
