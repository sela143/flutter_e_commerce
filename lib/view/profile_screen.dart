import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/profile_controller.dart';
import 'package:fetch_api/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      backgroundColor: mainColor,
      toolbarHeight: 70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        "Profile",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: Text(
                "LogOut",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }

  get _buildBody {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
      height: Get.height,
      width: Get.width,
      child: Column(
        spacing: 10,
        children: [
            Obx(() {
              return GestureDetector(
                onTap: (){
                  controller.uploadProfile();
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: mainColor.withValues(alpha: 0.3),
                  child: controller.isLoading.value || controller.loadingProfile.value
                      ? CircularProgressIndicator(color: mainColor)
                      :CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage:  controller.imageUrl.value.isNotEmpty
                        ? NetworkImage(controller.imageUrl.value)
                        : null,
                    child: controller.imageUrl.value.isEmpty
                        ? Icon(Icons.person, size: 55, color: mainColor)
                        : null,
                  ),
                ),
              );
            }),
        Obx(() => Column(
              spacing: 1,
              children: [
                controller.username.value.isEmpty?
                  Text(
                    "Username",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  )
                : Text(
                    controller.username.value,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                GestureDetector(
                  onTap: ()=> Get.toNamed(AppRoute.editProfile),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade300),
                  ),
                )
              ],
            )),
      ]),
    );
  }
}
