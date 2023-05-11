import 'package:hassadak/constants/strings.dart';

class PersonalDataResp {
  PersonalDataResp({
    required this.status,
    required this.data,
  });

  late final String status;
  late final Data data;

  PersonalDataResp.fromJson(Map<String, dynamic> json) {
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
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.telephone,
    required this.role,
    required this.image,
    required this.favouriteProduct,
    required this.favouriteCompany,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.passwordChangedAt,
  });

  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String username;
  late final String telephone;
  late final String role;
  late final String image;
  late final List<dynamic> favouriteProduct;
  late final List<dynamic> favouriteCompany;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final String passwordChangedAt;

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    username = json['username'] ?? "";
    telephone = json['telephone'] ?? "";
    role = json['role'] ?? "";
    image = json['image'] ?? UrlsStrings.noImageUrl;
    favouriteProduct =
        List.castFrom<dynamic, String>(json['favouriteProduct'] ?? "");
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? "");
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    V = json['__v'] ?? 0;
    passwordChangedAt = json['passwordChangedAt'] ?? "";
  }
}
