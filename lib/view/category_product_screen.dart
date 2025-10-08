import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/container_item_controller.dart';
import 'package:fetch_api/model/product_model.dart';
import 'package:fetch_api/widget/item_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryProductScreen extends StatelessWidget {
  final String category;
  final List<Product> products;
  final controller = Get.put(ContainerItemController());
  CategoryProductScreen({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappBar,
      body: _buildBody,
    );
  }

  get _buildappBar => AppBar(
        title: Text(
          category,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
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
                    top: -8,
                    right: -8,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Center(
                        child: Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      );

  get _buildBody {
    return Obx(() {
    if (controller.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
        child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 245,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ItemContainerWidget(
                index: index,
                product: product,
              );
            }),
      ),
    );
  });
  }
}
