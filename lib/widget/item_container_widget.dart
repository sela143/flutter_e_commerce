import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/favorite_controller.dart';
import 'package:fetch_api/model/product_model.dart';
import 'package:fetch_api/view/item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemContainerWidget extends StatelessWidget {
  const ItemContainerWidget({
    super.key,
    required this.product,
    required this.index,
  });
  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ItemDetailScreen(
          product: product,
          index: index,
          title: product.title,
          brand: product.brand ?? "",
          images: product.images,
          rating: product.rating.toString(),
          stock: product.stock.toString(),
          price: product.price,
          description: product.description,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                SizedBox(
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Center(
                          child: Image.network(
                            product.images[0],
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null)
                                // ignore: curly_braces_in_flow_control_structures
                                return child;
                              return Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 20,
              bottom: 47,
              child: Row(
                spacing: 75,
                children: [
                  Text("${product.stock}"),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 255, 200, 0),
                      ),
                      Text(
                        "${product.rating}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 15,
              left: 20,
              child: Text(
                "${product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: mainColor),
              ),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: GetBuilder<FavoriteController>(
                  builder: (favController) {
                    final isFav = favController.isFavorite(product);
                    return IconButton(
                      onPressed: () {
                        favController.toggleFavorite(product);
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 25,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                    );
                  },
                )),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: mainColor.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(12)),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
