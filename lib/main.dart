import 'package:credenze/const/global_colors.dart';
import 'package:credenze/screens/splash-screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'credenze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: GlobalColors.materialColor,
      ),
      localizationsDelegates: [
        MonthYearPickerLocalizations.delegate,
      ],
      home: SplashScreen(),
    );
  }
}
