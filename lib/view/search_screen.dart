import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/container_item_controller.dart';
import 'package:fetch_api/widget/item_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final containerItemController = Get.find<ContainerItemController>();
   SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(appBar: _buildAppBar, body: _buildBody,));
  }


  get _buildAppBar{
    return AppBar(
      toolbarHeight: 95,
      backgroundColor: mainColor,
      title: SizedBox(
        height: 55,
        width: Get.width,
        child: SearchBar(
          onChanged: (value){
            containerItemController.searchProducts(value);
          },
          autoFocus: true,
          leading: Icon(Icons.search, color: Colors.grey,),
          hintText: "Search here",
          hintStyle: WidgetStateProperty.all(TextStyle(color: Colors.grey)),
        ),
      ),
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
    );
  }
  get _buildBody{
    final results = containerItemController.searchResults;
    return Obx((){
      if (results.isEmpty) {
          return const Center(child: Text("No products found",
          style: TextStyle(color: Colors.grey, fontSize: 25, fontWeight: FontWeight.bold),
          ));
        }
      return SingleChildScrollView(
        child: GridView.builder(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 245,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final product = results[index];
                  return ItemContainerWidget(
                    product: product,
                    index: index,
                  );
                }),
      );
    });
  }
}