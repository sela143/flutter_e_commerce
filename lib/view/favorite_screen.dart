import 'package:fetch_api/color/primary_color.dart';
import 'package:fetch_api/controller/favorite_controller.dart';
import 'package:fetch_api/widget/item_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  final favController = Get.find<FavoriteController>();
  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      title: Text(
        "Favorite",
        style: TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: mainColor,
      toolbarHeight: 70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      centerTitle: true,
    );
  }

  get _buildBody {
    return Obx(
      () {
        return favController.favorites.isEmpty ? 
        Center(child: Padding(
          padding: const EdgeInsets.only(bottom: 180),
          child: Text("No Favorites", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey.shade300),),
        ))
        
      :  Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
          child: SingleChildScrollView(
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
                itemCount: favController.favorites.length,
                itemBuilder: (context, index) {
                  final product = favController.favorites[index];
                  return ItemContainerWidget(
                    index: index,
                    product: product,
                  );
                }),
          ),
        );
      },
    );
  }
}
