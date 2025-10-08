// ignore_for_file: constant_identifier_names

import 'dart:convert';

// JSON parser
ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

class ProductModel {
  List<Product> products;
  int total;
  int skip;
  int limit;

  ProductModel({
    this.products = const [],
    this.total = 0,
    this.skip = 0,
    this.limit = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: json["products"] != null
            ? List<Product>.from(
                json["products"].map((x) => Product.fromJson(x)))
            : [],
        total: json["total"] ?? 0,
        skip: json["skip"] ?? 0,
        limit: json["limit"] ?? 0,
      );
}

class Product {
  int? id;
  String title;
  String description;
  Category category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  List<String> tags;
  String? brand;
  String sku;
  int weight;
  Dimensions dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  AvailabilityStatus availabilityStatus;
  List<Review> reviews;
  ReturnPolicy returnPolicy;
  int minimumOrderQuantity;
  Meta meta;
  List<String> images;
  String? thumbnail;

  Product({
    this.id,
    this.title = '',
    this.description = '',
    this.category = Category.BEAUTY,
    this.price = 0.0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.stock = 0,
    this.tags = const [],
    this.brand,
    this.sku = '',
    this.weight = 0,
    Dimensions? dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus = AvailabilityStatus.IN_STOCK,
    this.reviews = const [],
    this.returnPolicy = ReturnPolicy.NO_RETURN_POLICY,
    this.minimumOrderQuantity = 1,
    Meta? meta,
    this.images = const [],
    this.thumbnail,
  })  : dimensions = dimensions ?? Dimensions(),
        meta = meta ?? Meta();

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        category:
            categoryValues.map[json["category"]] ?? Category.BEAUTY,
        price: (json["price"]?.toDouble()) ?? 0.0,
        discountPercentage: (json["discountPercentage"]?.toDouble()) ?? 0.0,
        rating: (json["rating"]?.toDouble()) ?? 0.0,
        stock: json["stock"] ?? 0,
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : [],
        brand: json["brand"],
        sku: json["sku"] ?? '',
        weight: json["weight"] ?? 0,
        dimensions: json["dimensions"] != null
            ? Dimensions.fromJson(json["dimensions"])
            : Dimensions(),
        warrantyInformation: json["warrantyInformation"],
        shippingInformation: json["shippingInformation"],
        availabilityStatus: availabilityStatusValues
                .map[json["availabilityStatus"]] ??
            AvailabilityStatus.IN_STOCK,
        reviews: json["reviews"] != null
            ? List<Review>.from(json["reviews"].map((x) => Review.fromJson(x)))
            : [],
        returnPolicy:
            returnPolicyValues.map[json["returnPolicy"]] ?? ReturnPolicy.NO_RETURN_POLICY,
        minimumOrderQuantity: json["minimumOrderQuantity"] ?? 1,
        meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : Meta(),
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : [],
        thumbnail: json["thumbnail"],
      );
}

enum AvailabilityStatus { IN_STOCK, LOW_STOCK }
final availabilityStatusValues = EnumValues({
  "In Stock": AvailabilityStatus.IN_STOCK,
  "Low Stock": AvailabilityStatus.LOW_STOCK,
});

enum Category { BEAUTY, FRAGRANCES, FURNITURE, GROCERIES }
final categoryValues = EnumValues({
  "beauty": Category.BEAUTY,
  "fragrances": Category.FRAGRANCES,
  "furniture": Category.FURNITURE,
  "groceries": Category.GROCERIES,
});

class Dimensions {
  double width;
  double height;
  double depth;

  Dimensions({
    this.width = 0.0,
    this.height = 0.0,
    this.depth = 0.0,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: (json["width"]?.toDouble()) ?? 0.0,
        height: (json["height"]?.toDouble()) ?? 0.0,
        depth: (json["depth"]?.toDouble()) ?? 0.0,
      );
}

class Meta {
  DateTime? createdAt;
  DateTime? updatedAt;
  String? barcode;
  String? qrCode;

  Meta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"])
            : null,
        barcode: json["barcode"],
        qrCode: json["qrCode"],
      );
}

enum ReturnPolicy {
  NO_RETURN_POLICY,
  THE_7_DAYS_RETURN_POLICY,
  THE_30_DAYS_RETURN_POLICY,
  THE_60_DAYS_RETURN_POLICY,
  THE_90_DAYS_RETURN_POLICY,
}

final returnPolicyValues = EnumValues({
  "No return policy": ReturnPolicy.NO_RETURN_POLICY,
  "7 days return policy": ReturnPolicy.THE_7_DAYS_RETURN_POLICY,
  "30 days return policy": ReturnPolicy.THE_30_DAYS_RETURN_POLICY,
  "60 days return policy": ReturnPolicy.THE_60_DAYS_RETURN_POLICY,
  "90 days return policy": ReturnPolicy.THE_90_DAYS_RETURN_POLICY,
});

class Review {
  int rating;
  String comment;
  DateTime? date;
  String? reviewerName;
  String? reviewerEmail;

  Review({
    this.rating = 0,
    this.comment = '',
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"] ?? 0,
        comment: json["comment"] ?? '',
        date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
        reviewerName: json["reviewerName"],
        reviewerEmail: json["reviewerEmail"],
      );
}

class EnumValues<T> {
  final Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
