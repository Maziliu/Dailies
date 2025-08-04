import 'package:dailies/dependency_setup.dart';
import 'package:dailies/ui/themes/themes.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view_model.dart';
import 'package:dailies/ui/views/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.black));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
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
      theme: defaultTheme,
      home: ChangeNotifierProvider(create: (_) => injector<DashboardViewModel>(), child: const DashboardView()),
    );
  }
}
