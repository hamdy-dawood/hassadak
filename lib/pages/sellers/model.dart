import 'package:hassadak/constants/strings.dart';

class AllSellersResponse {
  AllSellersResponse({
    this.status,
    this.results,
    this.data,
  });

  String? status;
  int? results;
  Data? data;

  AllSellersResponse.fromJson(Map<String, dynamic>? json) {
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

  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      doc = List.from(json['doc'])
          .map((e) => Doc.fromJson(e as Map<String, dynamic>))
          .toList();
    }
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
    this.whatsapp,
    this.facebookUrl,
    this.instaUrl,
    this.twitterUrl,
    this.description,
    this.role,
    this.image,
    this.likes,
    this.favouriteProduct,
    this.favouriteCompany,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? telephone;
  String? whatsapp;
  String? facebookUrl;
  String? instaUrl;
  String? twitterUrl;
  String? description;
  String? role;
  String? image;
  List<dynamic>? likes;
  List<dynamic>? favouriteProduct;
  List<dynamic>? favouriteCompany;
  String? createdAt;
  String? updatedAt;

  Doc.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['_id'] ?? "";
      firstName = json['firstName'] ?? "";
      lastName = json['lastName'] ?? "";
      email = json['email'] ?? "";
      username = json['username'] ?? "";
      telephone = json['telephone'] ?? "";
      whatsapp = json['whatsapp'] ?? "";
      facebookUrl = json['facebookUrl'] ?? "";
      instaUrl = json['instaUrl'] ?? "";
      twitterUrl = json['twitterUrl'] ?? "";
      description = json['description'] ?? "";
      role = json['role'] ?? "";
      image = json['image'] ?? UrlsStrings.noImageUrl;
      likes = List<dynamic>.from(json["likes"] ?? [].map((x) => x));
      favouriteProduct =
          List<dynamic>.from(json["favouriteProduct"] ?? [].map((x) => x));
      favouriteCompany =
          List<dynamic>.from(json["favouriteCompany"] ?? [].map((x) => x));
      createdAt = json['createdAt'] ?? "";
      updatedAt = json['updatedAt'] ?? "";
    }
  }
}
