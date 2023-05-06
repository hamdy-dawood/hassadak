class GetSellerResponse {
  GetSellerResponse({
    required this.status,
    required this.user,
    required this.getUserProduct,
  });

  late final String status;
  late final User user;
  late final List<GetUserProduct> getUserProduct;

  GetSellerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = User.fromJson(json['user']);
    getUserProduct = List.from(json['getUserProduct'])
        .map((e) => GetUserProduct.fromJson(e))
        .toList();
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.telephone,
    required this.whatsapp,
    required this.facebookUrl,
    required this.instaUrl,
    required this.twitterUrl,
    required this.description,
    required this.role,
    required this.favouriteProduct,
    required this.favouriteCompany,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });

  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String username;
  late final String telephone;
  late final String whatsapp;
  late final String facebookUrl;
  late final String instaUrl;
  late final String twitterUrl;
  late final String description;
  late final String role;
  late final List<dynamic> favouriteProduct;
  late final List<dynamic> favouriteCompany;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
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
    favouriteProduct =
        List.castFrom<dynamic, dynamic>(json['favouriteProduct']);
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }
}

class GetUserProduct {
  GetUserProduct({
    required this.name,
    required this.desc,
    required this.typeId,
    required this.categoryId,
    required this.productUrl,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.price,
    required this.discount,
    required this.discountPerc,
    required this.uploaderId,
    required this.uploaderName,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.id,
  });

  late final String name;
  late final String desc;
  late final String typeId;
  late final String categoryId;
  late final String productUrl;
  late final int ratingsAverage;
  late final int ratingsQuantity;
  late final int price;
  late final String discount;
  late final int discountPerc;
  late final String uploaderId;
  late final String uploaderName;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final String id;

  GetUserProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    typeId = json['typeId'];
    categoryId = json['categoryId'];
    productUrl = json['productUrl'];
    ratingsAverage = json['ratingsAverage'];
    ratingsQuantity = json['ratingsQuantity'];
    price = json['price'];
    discount = json['discount'];
    discountPerc = json['discountPerc'];
    uploaderId = json['uploaderId'];
    uploaderName = json['uploaderName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    id = json['id'];
  }
}
