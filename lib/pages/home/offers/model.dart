class OfferResponse {
  OfferResponse({
    required this.status,
    required this.results,
    required this.data,
  });

  late final String status;
  late final int results;
  late final Data data;

  OfferResponse.fromJson(Map<String, dynamic> json) {
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
    required this.products,
  });

  late final String id;
  late final String name;
  late final String desc;
  late final List<String> products;

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    desc = json['desc'];
    products = List.castFrom<dynamic, String>(json['products']);
  }
}
