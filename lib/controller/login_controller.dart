import 'package:fetch_api/routes/app_route.dart';
import 'package:fetch_api/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final _supabase = Supabase.instance.client;

  final isLoading = false.obs;

  Future<void> login(String email, String password) async{
    try {
      if(!formKey.currentState!.validate()) return;
      isLoading.value = true;

      final reaponse = await _supabase.auth.signInWithPassword(
        email: email,
        password: password);

      if(reaponse.session != null){
        LocalStorageService.instan.setString("userId", reaponse.user?.id ?? "");
        Get.offAllNamed(AppRoute.main);
      }
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }

}