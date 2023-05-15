import 'package:hassadak/constants/strings.dart';

class LoginResponse {
  LoginResponse({
    this.status,
    this.token,
    this.data,
  });

  String? status;
  String? token;
  Data? data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    token = json['token'] ?? "";
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    this.user,
  });

  User? user;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }
}

class User {
  User({
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    username = json['username'];
    telephone = json['telephone'] ?? "";
    role = json['role'] ?? "";
    image = json['image'] ?? UrlsStrings.noImageUrl;
    favouriteProduct =
        List.castFrom<dynamic, dynamic>(json['favouriteProduct'] ?? []);
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? []);
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    V = json['__v'] ?? 0;
  }
}
