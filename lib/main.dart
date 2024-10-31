import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_bank/widget/book_manager.dart';
import 'package:quest_bank/pages/bottomnav.dart';
import 'package:quest_bank/pages/filter.dart';
import 'package:quest_bank/pages/home.dart';
import 'package:quest_bank/pages/onboard.dart';
import 'package:quest_bank/pages/signup.dart';

void main() async {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      // home: OnBoardingScreen(),
      home: BottomNav(),
      // home: Signup(),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}
