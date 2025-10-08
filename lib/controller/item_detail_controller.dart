import 'package:fetch_api/controller/card_controller.dart';
import 'package:fetch_api/model/product_model.dart';
import 'package:get/get.dart';

class ItemDetailController extends GetxController{

  var _count = 0.obs;
  var totalPrice = 0.0.obs;
  get getCount => _count.value;

  
  void increment(Product product) {
    _count++;
    totalPrice.value = (totalPrice.value + product.price).toPrecision(2);
  }
  void deincrement(Product product) {
    if (_count > 0) {
      _count--;
      totalPrice.value = (totalPrice.value - product.price).toPrecision(2);
    }
  }

  void addToCard(Product product){
    if(_count > 0){
      final cardController = Get.find<CardController>();
      cardController.addToCard(product, _count.value);
      _count.value =0;
      totalPrice.value = 0;
    }
  }
}