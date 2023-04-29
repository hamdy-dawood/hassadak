class AllCategories {
  AllCategories({
    required this.status,
    required this.results,
    required this.data,
  });

  late final String status;
  late final int results;
  late final Data data;

  AllCategories.fromJson(Map<String, dynamic> json) {
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
    required this.id,
    required this.name,
    required this.desc,
    required this.productsIds,
    required this.productTypesIds,
    required this.createdAt,
    required this.updatedAt,
  });

  late final String id;
  late final String name;
  late final String desc;
  late final List<dynamic> productsIds;
  late final List<dynamic> productTypesIds;
  late final String createdAt;
  late final String updatedAt;

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    productsIds = List.castFrom<dynamic, dynamic>(json['ProductsIds']);
    productTypesIds = List.castFrom<dynamic, dynamic>(json['ProductTypesIds']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
