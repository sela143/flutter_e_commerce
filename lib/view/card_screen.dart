import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardScreen extends StatelessWidget {
  final controller = Get.find<CardController>();
  CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Order",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
      ),
      backgroundColor: mainColor,
      toolbarHeight: 70,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
    );
  }

  get _buildBody {
    return Obx(() {
      return controller.cardItem.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 180),
                child: Text(
                  "No Product",
                  style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            )
          : _listViewItem;
    });
  }

  get _listViewItem {
    return ListView.builder(
        itemCount: controller.cardItem.length,
        itemBuilder: (context, index) {
          final item = controller.cardItem[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: [
                Obx((){
                 return Stack(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 3, color: mainColor)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          item.product.thumbnail ?? ""))),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item.product.title} (${item.quantity.value})",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "\$${item.product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: mainColor),
                                ),
                                Text("${item.product.warrantyInformation}"),
                                Text("${item.product.shippingInformation}")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
                })
              ],
            ),
          );
        });
  }
}
