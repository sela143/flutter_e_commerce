import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/container_item_controller.dart';
import 'package:fetch_api/view/category_product_screen.dart';
import 'package:fetch_api/widget/item_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyItem extends StatelessWidget {
  final controller = Get.put(ContainerItemController());
  BodyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Offers",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 160,
          child: PageView.builder(
              clipBehavior: Clip.none,
              itemCount: controller.images.length,
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2,color: mainColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(1, 8),
                          ),
                        ]
                        ),
                    child: Image.asset(
                      controller.images[index],
                      fit: BoxFit.cover,
                    ));
              }),
        ),
        Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(controller.categories.length, (index) {
                final category = controller.categories[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(CategoryProductScreen(
                      category: category,
                      products: controller.getProductbyCatrgory(category),
                    ));
                  },
                  child: Column(
                    spacing: 5,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            image: DecorationImage(
                                image: AssetImage(controller.image[index]),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        category,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              }),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  );
                }
                return GridView.builder(
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
                    itemCount: controller.productModel.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.productModel.products[index];
                      return ItemContainerWidget(
                        product: product,
                        index: index,
                      );
                    });
              }),
            ],
          ),
        ),
      ],
    );
  }
}
