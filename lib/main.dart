import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';
import 'package:pat_e/core/utils/routing/route_generator.dart';
import 'package:pat_e/core/utils/themes/app_theme.dart';
import 'package:pat_e/ui/views/onboard/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:pat_e/firebase_options.dart';

Future<void> main() async {
  //runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ThemeProvider(), // ThemeProvider kullanarak global state yönetimi
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: TTexts.appName,
          themeMode: themeProvider.themeMode, // Buradan themeMode değerini al
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          initialRoute: RouteConstant.onBoardScreenRoute,
          onGenerateRoute: RouterGenerator.generateRoute,
          home: const OnboardingScreen(), //OnboardingScreen(),
        );
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Değişiklikleri dinleyenleri bilgilendir
  }
}
