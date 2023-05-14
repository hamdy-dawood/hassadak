import 'package:hassadak/constants/strings.dart';

class PersonalDataResp {
  PersonalDataResp({
    this.status,
    this.data,
  });

  String? status;
  Data? data;

  PersonalDataResp.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'] ?? "";
      data = Data.fromJson(json['data'] as Map<String, dynamic>);
    }
  }
}

class Data {
  Data({
    this.doc,
  });

  Doc? doc;

  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      doc = Doc.fromJson(json['doc']);
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
    this.role,
    this.image,
    this.favouriteProduct,
    this.favouriteCompany,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.passwordChangedAt,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? telephone;
  String? role;
  String? image;
  List<dynamic>? favouriteProduct;
  List<dynamic>? favouriteCompany;
  String? createdAt;
  String? updatedAt;
  int? V;
  String? passwordChangedAt;

  Doc.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['_id'] ?? "";
      firstName = json['firstName'] ?? "";
      lastName = json['lastName'] ?? "";
      email = json['email'] ?? "";
      username = json['username'] ?? "";
      telephone = json['telephone'] ?? "";
      role = json['role'] ?? "";
      image = json['image'] ?? UrlsStrings.noImageUrl;
      favouriteProduct =
          List.castFrom<dynamic, String>(json['favouriteProduct'] ?? []);
      favouriteCompany =
          List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? []);
      createdAt = json['createdAt'] ?? "";
      updatedAt = json['updatedAt'] ?? "";
      V = json['__v'] ?? 0;
      passwordChangedAt = json['passwordChangedAt'] ?? "";
    }
  }
}
