import 'dart:convert';

AllSellersResponse getSellersFromJson(String str) =>
    AllSellersResponse.fromJson(json.decode(str));

class AllSellersResponse {
  String status;
  int results;
  Data data;

  AllSellersResponse({
    required this.status,
    required this.results,
    required this.data,
  });

  factory AllSellersResponse.fromJson(Map<String, dynamic> json) =>
      AllSellersResponse(
        status: json["status"],
        results: json["results"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  List<Doc> doc;

  Data({
    required this.doc,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        doc: List<Doc>.from(json["doc"].map((x) => Doc.fromJson(x))),
      );
}

class Doc {
  String id;
  String firstName;
  String lastName;
  String email;
  String username;
  String telephone;
  String whatsapp;
  String facebookUrl;
  String instaUrl;
  String? twitterUrl;
  String? description;
  String role;
  List<dynamic> favouriteProduct;
  List<dynamic> favouriteCompany;
  DateTime createdAt;
  DateTime updatedAt;

  Doc({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.telephone,
    required this.whatsapp,
    required this.facebookUrl,
    required this.instaUrl,
    this.twitterUrl,
    this.description,
    required this.role,
    required this.favouriteProduct,
    required this.favouriteCompany,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        telephone: json["telephone"],
        whatsapp: json["whatsapp"],
        facebookUrl: json["facebookUrl"],
        instaUrl: json["instaUrl"],
        twitterUrl: json["twitterUrl"],
        description: json["description"],
        role: json["role"],
        favouriteProduct:
            List<dynamic>.from(json["favouriteProduct"].map((x) => x)),
        favouriteCompany:
            List<dynamic>.from(json["favouriteCompany"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
