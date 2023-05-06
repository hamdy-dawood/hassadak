class AllProductsResponse {
  AllProductsResponse({
    required this.status,
    required this.results,
    required this.data,
  });

  late final String status;
  late final int results;
  late final Data data;

  AllProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    required this.doc,
  });

  late final List<Doc> doc;

  Data.fromJson(Map<String, dynamic> json) {
    doc = List.from(json['doc']).map((e) => Doc.fromJson(e)).toList();
  }
}

class Doc {
  Doc({
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
    required this.status,
    required this.id,
  });

  late final String name;
  late final String desc;
  late final String typeId;
  late final String categoryId;
  late final String productUrl;
  late final num ratingsAverage;
  late final num ratingsQuantity;
  late final num price;
  late final String createdAt;
  late final String updatedAt;
  late final bool status;
  late final String id;

  Doc.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    id = json['id'];
  }
}
