class LoginResponse {
  LoginResponse({
    required this.status,
    required this.token,
    required this.data,
  });

  late final String status;
  late final String token;
  late final Data data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    token = json['token'] ?? "";
    data = Data.fromJson(json['data'] ?? "");
  }
}

class Data {
  Data({
    required this.user,
  });

  late final User user;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user'] ?? "");
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
    required this.role,
    required this.image,
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
  late final String role;
  late final String image;
  late final List<dynamic> favouriteProduct;
  late final List<dynamic> favouriteCompany;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    username = json['username'];
    telephone = json['telephone'] ?? "";
    role = json['role'] ?? "";
    image = json['image'] ?? "";
    favouriteProduct =
        List.castFrom<dynamic, dynamic>(json['favouriteProduct'] ?? "");
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? "");
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    V = json['__v'] ?? "";
  }
}
