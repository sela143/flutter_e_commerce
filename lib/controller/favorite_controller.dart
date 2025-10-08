
import 'package:fetch_api/model/product_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController{
  RxList favorites = <Product>[].obs;

  bool isFavorite(Product product) {
    return favorites.contains(product);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
    update(); // <- this refreshes the GetBuilder
  }
}