import 'package:fetch_api/auth/splash_screen.dart';
import 'package:fetch_api/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      getPages: AppRoute.pages,
      // initialRoute: AppRoute.home,
    );
  }
}