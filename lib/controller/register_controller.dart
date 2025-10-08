import 'package:fetch_api/routes/app_route.dart';
import 'package:fetch_api/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final cfPasswordCtl = TextEditingController();
  final _supabase = Supabase.instance.client;

  var isLoading = false.obs;

  Future<void> register(String email, String password) async{
    try {
      if(!formKey.currentState!.validate()) return;

      if(passwordCtl.text != cfPasswordCtl.text) return;
      isLoading.value = true;

      final response = await _supabase.auth.signUp(
        email: email, 
        password: password);

      if(response.user != null){
        LocalStorageService.instan.setString("userId", response.user?.id?? "");
        Get.offAllNamed(AppRoute.login);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally{
      isLoading.value = false;
    }
  }
}