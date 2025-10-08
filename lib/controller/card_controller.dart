import 'package:fetch_api/model/product_model.dart';
import 'package:get/get.dart';

class CardItem {
  final Product product;
  final RxInt quantity ;

  CardItem(this.product, int qty) : quantity  = qty.obs;
}

class CardController extends GetxController {
  var cardItem = <CardItem>[].obs;

  void addToCard(Product product, int qty){
    final index = cardItem.indexWhere((item) => item.product.id == product.id);
    if(index >= 0){
      cardItem[index].quantity.value += qty;
    }else{
      cardItem.add(CardItem(product, qty));
    }
  }

  void increaseQuantity(CardItem item) => item.quantity.value++;
  void decreaseQuantity(CardItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    } else {
      cardItem.remove(item);
    }
  }
  double get totalPrice => cardItem.fold(0, (sum, item) => sum + item.product.price * item.quantity.value,);

}
