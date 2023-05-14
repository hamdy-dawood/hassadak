class FavouriteResponse {
  FavouriteResponse({
    this.status,
    this.products,
  });

  String? status;
  List<Products>? products;

  FavouriteResponse.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'] ?? "";
      products = List.from(json['products'] ?? [])
          .map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }
}

class Products {
  Products({
    this.id,
    this.name,
    this.desc,
    this.typeId,
    this.categoryId,
    this.productUrl,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.price,
    this.discountPerc,
    this.discount,
    this.uploaderId,
    this.uploaderName,
    this.createdAt,
    this.updatedAt,
    this.V,
  });

  String? id;
  String? name;
  String? desc;
  String? typeId;
  String? categoryId;
  String? productUrl;
  num? ratingsAverage;
  num? ratingsQuantity;
  num? price;
  num? discountPerc;
  String? discount;
  String? uploaderId;
  String? uploaderName;
  String? createdAt;
  String? updatedAt;
  num? V;

  Products.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['_id'] ?? "";
      name = json['name'] ?? "";
      desc = json['desc'] ?? "";
      typeId = json['typeId'] ?? "";
      categoryId = json['categoryId'] ?? "";
      productUrl = json['productUrl'] ?? "";
      ratingsAverage = json['ratingsAverage'] ?? 0;
      ratingsQuantity = json['ratingsQuantity'] ?? 0;
      price = json['price'] ?? 0;
      discountPerc = json['discountPerc'] ?? 0;
      discount = json['discount'] ?? "";
      uploaderId = json['uploaderId'] ?? "";
      uploaderName = json['uploaderName'] ?? "لا يوجد اسم";
      createdAt = json['createdAt'] ?? "";
      updatedAt = json['updatedAt'] ?? "";
      V = json['__v'] ?? "";
    }
  }
}
