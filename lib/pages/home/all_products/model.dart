class AllProductsResponse {
  AllProductsResponse({
    this.status,
    this.results,
    this.data,
  });

  String? status;
  int? results;
  Data? data;

  AllProductsResponse.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'] ?? "";
      results = json['results'] ?? 0;
      data = Data.fromJson(json['data'] as Map<String, dynamic>);
    }
  }
}

class Data {
  Data({
    this.doc,
  });

  List<Doc>? doc;

  Data.fromJson(Map<String, dynamic> json) {
    doc = List.from(json['doc'] ?? [])
        .map((e) => Doc.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class Doc {
  Doc({
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
    this.status,
    this.id,
  });

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
  bool? status;
  String? id;

  Doc.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'] ?? "لا يوجد";
      desc = json['desc'] ?? "";
      typeId = json['typeId'] ?? "";
      categoryId = json['categoryId'] ?? "";
      productUrl = json['productUrl'] ?? "";
      ratingsAverage = json['ratingsAverage'] ?? 0;
      ratingsQuantity = json['ratingsQuantity'] ?? 0;
      price = json['price'] ?? 0;
      discountPerc = json['price'] ?? 0;
      discount = json['discount'] ?? "";
      uploaderId = json['uploaderId'] ?? "";
      uploaderName = json['uploaderName'] ??"لا يوجد اسم";
      createdAt = json['createdAt'] ?? "";
      updatedAt = json['updatedAt'] ?? "";
      status = json['status'] ?? false;
      id = json['id'] ?? "";
    }
  }
}
