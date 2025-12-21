import 'package:dailies_v2/ui/dashboard/dashboard.dart';
import 'package:dailies_v2/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart';

final GlobalKey<ScaffoldMessengerState> GLOBAL_SCAFFOLD_MESSENGER_KEY =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );

  initializeTimeZones();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: GLOBAL_SCAFFOLD_MESSENGER_KEY,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const Dashboard(),
    );
  }
}
