import 'package:fetch_api/controller/main_controller.dart';
import 'package:fetch_api/view/card_screen.dart';
import 'package:fetch_api/view/favorite_screen.dart';
import 'package:fetch_api/view/home_screen.dart';
import 'package:fetch_api/view/profile_screen.dart';
import 'package:fetch_api/widget/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final controller = Get.put(MainController());
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      HomeScreen(),
      FavoriteScreen(),
      CardScreen(),
      ProfileScreen(),
    ];
    return Obx(() => Scaffold(
          extendBody: true,
          body: screen[controller.getIndex],
          bottomNavigationBar: _buidBottomNavigationBar,
        ));
  }

  get _buidBottomNavigationBar {
    return BottomNavigationBarWidget(
      onChange: (index) => controller.changeIndex(index),
    );
  }
}
