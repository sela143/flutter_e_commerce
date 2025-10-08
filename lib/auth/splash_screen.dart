import 'package:fetch_api/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color/primary_color.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashController());
   SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: mainColor,
        child: Center(
          child: Text(
            "Ecommerce App",
            style: TextStyle(
                color: Colors.white, fontSize: 35, 
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
