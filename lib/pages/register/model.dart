class RegisterResponse {
  RegisterResponse({
    this.status,
    this.token,
    this.data,
  });

  String? status;
  String? token;
  Data? data;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
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
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.telephone,
    this.role,
    this.likes,
    this.image,
    this.favouriteProduct,
    this.favouriteCompany,
    this.createdAt,
    this.active,
    this.id,
    this.updatedAt,
    this.V,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? telephone;
  String? role;
  List<dynamic>? likes;
  String? image;
  List<dynamic>? favouriteProduct;
  List<dynamic>? favouriteCompany;
  String? createdAt;
  bool? active;
  String? id;
  String? updatedAt;
  int? V;

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    username = json['username'] ?? "";
    telephone = json['telephone'] ?? "";
    role = json['role'] ?? "";
    likes = List.castFrom<dynamic, dynamic>(json['likes'] ?? []);
    image = json['image'] ?? "";
    favouriteProduct =
        List.castFrom<dynamic, dynamic>(json['favouriteProduct'] ?? []);
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? []);
    createdAt = json['createdAt'] ?? "";
    active = json['active'] ?? false;
    id = json['_id'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    V = json['__v'] ?? 0;
  }
}
