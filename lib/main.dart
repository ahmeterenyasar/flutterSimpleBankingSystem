import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'utils/constants.dart';
import 'utils/theme.dart';
import 'screens/splash_screen.dart';

void main() {
  initializeDateFormatting('tr_TR', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
