import 'package:hassadak/constants/strings.dart';

class AllProductsResponse {
  String? status;
  int? results;
  Data? data;

  AllProductsResponse({this.status, this.results, this.data});

  AllProductsResponse.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'] ?? "";
      results = json['results'] ?? 0;
      data = Data.fromJson(json['data'] ?? Map<String, dynamic>);
    }
  }
}

class Data {
  List<Doc>? doc;

  Data({this.doc});

  Data.fromJson(Map<String, dynamic> json) {
    doc = List.from(json['doc'] ?? [])
        .map((e) => Doc.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class Doc {
  String? name;
  String? desc;
  String? typeId;
  String? categoryId;
  String? productUrl;
  num? ratingsAverage;
  num? ratingsQuantity;
  num? price;
  String? discount;
  num? discountPerc;
  String? uploaderId;
  String? uploaderName;
  String? createdAt;
  String? updatedAt;
  String? userPhoto;
  User? user;
  String? id;
  bool? status;

  Doc({
    this.name,
    this.desc,
    this.typeId,
    this.categoryId,
    this.productUrl,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.price,
    this.discount,
    this.discountPerc,
    this.uploaderId,
    this.uploaderName,
    this.createdAt,
    this.updatedAt,
    this.userPhoto,
    this.user,
    this.id,
    this.status,
  });

  Doc.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'];
      desc = json['desc'];
      typeId = json['typeId'];
      categoryId = json['categoryId'];
      productUrl = json['productUrl'];
      ratingsAverage = json['ratingsAverage'];
      ratingsQuantity = json['ratingsQuantity'];
      price = json['price'];
      discount = json['discount'];
      discountPerc = json['discountPerc'] ?? 0;
      uploaderId = json['uploaderId'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      uploaderName = json['uploaderName'] ?? "لا يوجد اسم";
      userPhoto = json['userPhoto'] ?? UrlsStrings.userImageUrl;
      user = json['user'] != null ? User.fromJson(json['user']) : null;
      id = json['id'];
      status = json['status'] ?? false;
    }
  }
}

class User {
  String? sId;
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
  List<dynamic>? likes;
  List<dynamic>? favouriteProduct;
  List<dynamic>? favouriteCompany;
  String? createdAt;
  String? updatedAt;
  num? iV;
  String? cloudinaryId;
  String? userPhoto;
  String? image;
  String? passwordChangedAt;
  String? passwordResetTokenOTP;

  User(
      {this.sId,
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
      this.likes,
      this.favouriteProduct,
      this.favouriteCompany,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.cloudinaryId,
      this.userPhoto,
      this.image,
      this.passwordChangedAt,
      this.passwordResetTokenOTP});

  User.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      sId = json['_id'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      email = json['email'];
      username = json['username'];
      telephone = json['telephone'];
      whatsapp = json['whatsapp'];
      facebookUrl = json['facebookUrl'];
      instaUrl = json['instaUrl'];
      twitterUrl = json['twitterUrl'];
      description = json['description'];
      role = json['role'];
      likes = List.castFrom<dynamic, dynamic>(json['likes'] ?? []);
      favouriteProduct =
          List.castFrom<dynamic, dynamic>(json['favouriteProduct'] ?? []);
      favouriteCompany =
          List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? []);
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      iV = json['__v'];
      cloudinaryId = json['cloudinaryId'];
      userPhoto = json['userPhoto'] ?? UrlsStrings.userImageUrl;
      image = json['image'] ?? UrlsStrings.userImageUrl;
      passwordChangedAt = json['passwordChangedAt'];
      passwordResetTokenOTP = json['passwordResetTokenOTP'];
    }
  }
}
