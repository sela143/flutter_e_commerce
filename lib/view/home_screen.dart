import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/home_controller.dart';
import 'package:fetch_api/controller/profile_controller.dart';
import 'package:fetch_api/routes/app_route.dart';
import 'package:fetch_api/widget/body_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _customScrollView,
    );
  }

  get _customScrollView {
    return CustomScrollView(
      slivers: [_sliverAppBar, _sliverList],
    );
  }

  get _sliverAppBar {
    final ProfileController profileController = Get.find();
    return SliverAppBar(
              clipBehavior: Clip.none,
              // expandedHeight: 150,
              title: Row(
                spacing: 15,
                children: [
          Obx(() => CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: profileController.imageUrl.value.isNotEmpty
                    ? NetworkImage(profileController.imageUrl.value)
                    : null,
                child: profileController.imageUrl.value.isEmpty
                    ? Icon(Icons.person, size: 30, color: Colors.white)
                    : null,
              ),
            )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => profileController.username.isEmpty? 
              Text("Guy!",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25))
              :Text("${profileController.username.value}!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25))),
              Obx(() => Text(
                    controller.getGretting,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(95),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoute.search),
            child: Container(
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Row(
                    spacing: 5,
                    children: [
                      Icon(Icons.search, color: Colors.grey,size: 25,),
                      Text("Search",style: TextStyle(color: Colors.grey, fontSize: 15),)
                    ],
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }

  get _sliverList {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            BodyItem(),
          ],
        ),
      ),
    );
  }
}
