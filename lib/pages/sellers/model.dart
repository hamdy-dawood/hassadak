import 'package:hassadak/constants/strings.dart';

class AllSellersResponse {
  AllSellersResponse({
    required this.status,
    required this.results,
    required this.data,
  });

  late final String status;
  late final int results;
  late final Data data;

  AllSellersResponse.fromJson(Map<String, dynamic> json) {
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
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.telephone,
    this.role,
    required this.image,
    this.likes,
    this.favouriteProduct,
    this.favouriteCompany,
    this.createdAt,
    this.updatedAt,
  });

  late final String? id;
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? username;
  late final String? telephone;
  late final String? role;
  late final String image;
  late final List<dynamic>? likes;
  late final List<dynamic>? favouriteProduct;
  late final List<dynamic>? favouriteCompany;
  late final String? createdAt;
  late final String? updatedAt;

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    username = json['username'] ?? "";
    telephone = json['telephone'];
    role = json['role'];
    image = json['image'] ?? UrlsStrings.noImageUrl;
    likes = List<dynamic>.from(json["likes"].map((x) => x));
    favouriteProduct =
        List<dynamic>.from(json["favouriteProduct"].map((x) => x));
    favouriteCompany =
        List<dynamic>.from(json["favouriteCompany"].map((x) => x));
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
