import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/item_detail_controller.dart';
import 'package:fetch_api/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetailScreen extends StatelessWidget {
  final Product product;
  final int index;
  final String title;
  final String brand;
  final List<String> images;
  final String rating;
  final String stock;
  final double price;
  final String description;

  final controller = Get.put(ItemDetailController());

  ItemDetailScreen(
      {super.key,
      required this.product,
      required this.index,
      required this.title,
      required this.brand,
      required this.images,
      required this.rating,
      required this.stock,
      required this.price,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappBar,
      body: _buildBody,
    );
  }

  get _buildappBar {
    var appBar = AppBar(
      toolbarHeight: 70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      backgroundColor: mainColor,
      centerTitle: true,
      title: brand == ''
          ? Text(
              title,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          : Text(
              brand,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
      leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30,
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 30,
              ),
              Positioned(
                  top: -9,
                  right: -9,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Center(
                      child: Obx(() => Text(
                            "${controller.getCount}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12),
                          )),
                    ),
                  ))
            ],
          ),
        )
      ],
    );
    return appBar;
  }

  get _buildBody {
    return ListView(
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(images[0]))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Row(spacing: 10, children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          rating,
                          style: TextStyle(fontSize: 17),
                        )
                      ]),
                      Text(
                        "Stock: $stock",
                        style: TextStyle(fontSize: 17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$$price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                  color: mainColor),
                            ),
                            Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                  border: Border.all(color: mainColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Obx(() => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.deincrement(product);
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: mainColor,
                                          )),
                                      Text(
                                        "${controller.getCount}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            controller.increment(product);
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: mainColor,
                                          )),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "About this item",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        description,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 170),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TOTAL",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Obx(() 
                        => controller.totalPrice < 1? Text("",
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: mainColor),)
                        :Text( "\$${controller.totalPrice.value.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: mainColor),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: GestureDetector(
                        onTap: ()=> controller.addToCard(product),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            Text(
                              "Add to Card",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
