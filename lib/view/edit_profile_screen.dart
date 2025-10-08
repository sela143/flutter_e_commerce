import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final profileController = Get.put(ProfileController());
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      toolbarHeight: 70,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      title: Text(
        "Edit Profile",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  get _buildBody {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        spacing: 30,
        children: [
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2, color: mainColor)),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20))),
                    child: TextField(
                        controller: profileController.editCtl,
                        onChanged: (value) {
                          profileController.username.value = value; // update reactive value
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: profileController.username.value,
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                  ),
                ],
              )),
          SizedBox(
            height: 50,
            width: 100,
            child: ElevatedButton(
                onPressed: () {
                  profileController.setUsername(
                    profileController.editCtl.text,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(mainColor),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          )
        ],
      ),
    );
  }
}
