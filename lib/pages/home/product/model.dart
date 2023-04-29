class ProductModel {
  ProductModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final Data data;

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    required this.doc,
  });

  late final Doc doc;

  Data.fromJson(Map<String, dynamic> json) {
    doc = Doc.fromJson(json['doc']);
  }
}

class Doc {
  Doc({
    required this.id,
    required this.name,
    required this.desc,
    required this.typeId,
    required this.categoryId,
    required this.productUrl,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });

  late final String id;
  late final String name;
  late final String desc;
  late final String typeId;
  late final String categoryId;
  late final String productUrl;
  late final int ratingsAverage;
  late final int ratingsQuantity;
  late final int price;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    desc = json['desc'];
    typeId = json['typeId'];
    categoryId = json['categoryId'];
    productUrl = json['productUrl'];
    ratingsAverage = json['ratingsAverage'];
    ratingsQuantity = json['ratingsQuantity'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }
}
