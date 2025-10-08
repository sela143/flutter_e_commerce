import 'dart:async';
import 'package:get/get.dart';

class HomeController extends GetxController{

  var gretting = ''.obs;
  get getGretting => gretting.value;
  Timer? _timer;
  @override
  void onInit() {
    updateGretting();
    super.onInit();
  }
  void updateGretting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      gretting.value = 'Good Morning';
    } else if (hour < 18) {
      gretting.value = 'Good Afternoon';
    } else {
      gretting.value = 'Good Evening';
    }
  }
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}