import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/register_controller.dart';
import 'package:fetch_api/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final controller = Get.put(RegisterController());
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: _buildBody,
        ));
  }

  get _buildBody {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          color: mainColor,
        ),
        SafeArea(
          bottom: false,
          child: Container(
            width: Get.width,
            height: Get.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
              child: Column(
                spacing: 20,
                children: [
                  Text(
                    "Resgister Account",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Form(
                      key: controller.formKey,
                      child: Column(spacing: 20, children: [
                        TextFormField(
                          controller: controller.emailCtl,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff0C153D),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff0C153D),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: controller.passwordCtl,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff0C153D),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff0C153D),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: controller.cfPasswordCtl,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff0C153D),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff0C153D),
                              ),
                            ),
                          ),
                        ),
                      ])),
                  SizedBox(
                    width: Get.width,
                    height: 55,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.register(controller.emailCtl.text,
                              controller.passwordCtl.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Obx(() => controller.isLoading.value? CircularProgressIndicator(color: Colors.white,)
                        : Text("Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.login),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Already have account? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
