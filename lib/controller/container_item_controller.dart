import 'dart:convert';
import 'package:fetch_api/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContainerItemController extends GetxController{

  ProductModel productModel = ProductModel();
  var categories = <String>[].obs;
  var searchResults = <Product>[].obs;
  List<String> images = [
    "asset/images/slide1.webp",
    "asset/images/slide2.webp",
    "asset/images/slide3.webp",
  ];
  List<String> image = [
    "asset/images/category1.jpg",
    "asset/images/category2.webp",
    "asset/images/category3.jpg",
    "asset/images/category4.webp",
  ];

  final isLoading = true.obs;
  @override
  void onInit() async{
    await fetchData();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      var url = Uri.https("dummyjson.com", "/products");
      var response = await http.get(url);

      var data = jsonDecode(response.body);
      productModel = ProductModel.fromJson(data);

      var uniqueCategories = productModel.products.map((e) => e.category.toString().split('.').last).toSet();
      categories.assignAll(uniqueCategories.toList());

      searchResults.assignAll(productModel.products);
      

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void searchProducts(String query){
    if(query.isEmpty){
      searchResults.assignAll(productModel.products);
    }else{
      searchResults.assignAll(productModel.products.where((e) => e.title.toLowerCase().contains(query.toLowerCase())).toList());
    }
  }
  List<Product> getProductbyCatrgory(String category){
    return productModel.products.where((e) => e.category.toString().split('.').last == category).toList();
  }
}