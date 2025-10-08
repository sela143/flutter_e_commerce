import 'package:fetch_api/routes/app_route.dart';
import 'package:fetch_api/services/local_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  final userId = "".obs;

  @override
  void onInit() {
    LocalStorageService.instan.init();
    userId.value = LocalStorageService.instan.getString("userId")?? "";
    Future.delayed(const Duration(seconds: 2), (){
      if(userId.value == ""){
        Get.offAllNamed(AppRoute.login);
      }else{
        Get.offAllNamed(AppRoute.main);
      }
    });
    super.onInit();
  }
}