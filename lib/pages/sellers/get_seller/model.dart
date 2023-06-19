import 'package:hassadak/constants/strings.dart';

class GetSellerResponse {
  GetSellerResponse({
    this.status,
    this.user,
    this.getUserProduct,
  });

  String? status;
  User? user;
  List<GetUserProduct>? getUserProduct;

  GetSellerResponse.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'] ?? "";
      user = User.fromJson(json['user'] ?? Map<String, dynamic>);
      getUserProduct = List.from(json['getUserProduct'] ?? [])
          .map((e) => GetUserProduct.fromJson(e as Map<String, dynamic>))
          .toList();
    }
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
    this.whatsapp,
    this.facebookUrl,
    this.instaUrl,
    this.twitterUrl,
    this.description,
    this.role,
    this.image,
    this.userPhoto,
    this.likes,
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
  String? whatsapp;
  String? facebookUrl;
  String? instaUrl;
  String? twitterUrl;
  String? description;
  String? role;
  String? image;
  String? userPhoto;
  List<dynamic>? likes;
  List<dynamic>? favouriteProduct;
  List<dynamic>? favouriteCompany;
  String? createdAt;
  String? updatedAt;
  num? V;

  User.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['_id'] ?? "";
      firstName = json['firstName'] ?? "";
      lastName = json['lastName'] ?? "";
      email = json['email'] ?? "";
      username = json['username'] ?? "";
      telephone = json['telephone'] ?? "";
      whatsapp = json['whatsapp'] ?? "";
      facebookUrl = json['facebookUrl'] ?? "https://www.facebook.com/";
      instaUrl = json['instaUrl'] ?? "https://www.instagram.com/";
      twitterUrl = json['twitterUrl'] ?? "https://twitter.com/";
      description = json['description'] ?? "no description";
      role = json['role'] ?? "";
      image = json['image'] ?? UrlsStrings.userImageUrl;
      userPhoto = json['userPhoto'] ?? UrlsStrings.userImageUrl;
      likes = List.castFrom<dynamic, dynamic>(json['likes'] ?? []);
      favouriteProduct =
          List.castFrom<dynamic, dynamic>(json['favouriteProduct'] ?? []);
      favouriteCompany =
          List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? []);
      createdAt = json['createdAt'] ?? "";
      updatedAt = json['updatedAt'] ?? "";
      V = json['__v'] ?? 0;
    }
  }
}

class GetUserProduct {
  GetUserProduct({
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
    this.V,
    this.id,
    this.sellerPhone,
    this.sellerWhatsapp,
    this.status,
  });

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
  num? V;
  String? id;
  String? sellerPhone;
  String? sellerWhatsapp;
  bool? status;

  GetUserProduct.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      name = json['name'] ?? "";
      desc = json['desc'] ?? "";
      typeId = json['typeId'] ?? "";
      categoryId = json['categoryId'] ?? "";
      productUrl = json['productUrl'] ?? "";
      ratingsAverage = json['ratingsAverage'] ?? 0;
      ratingsQuantity = json['ratingsQuantity'] ?? 0;
      price = json['price'] ?? 0;
      discount = json['discount'] ?? "";
      discountPerc = json['discountPerc'] ?? 0;
      uploaderId = json['uploaderId'] ?? "";
      uploaderName = json['uploaderName'] ?? "";
      createdAt = json['createdAt'] ?? "";
      updatedAt = json['updatedAt'] ?? "";
      V = json['__v'] ?? 0;
      id = json['id'] ?? "";
      sellerPhone = json['sellerPhone'] ?? "010";
      sellerWhatsapp = json['sellerWhatsapp'] ?? "010";
      status = json['status'] ?? false;
    }
  }
}
