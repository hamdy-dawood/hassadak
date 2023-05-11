class RegisterResponse {
  RegisterResponse({
    required this.status,
    required this.token,
    required this.data,
  });

  late final String status;
  late final String token;
  late final Data data;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    required this.user,
  });

  late final User user;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }
}

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.telephone,
    required this.role,
    required this.likes,
    required this.image,
    required this.favouriteProduct,
    required this.favouriteCompany,
    required this.createdAt,
    required this.active,
    required this.id,
    required this.updatedAt,
    required this.V,
  });

  late final String firstName;
  late final String lastName;
  late final String email;
  late final String username;
  late final String telephone;
  late final String role;
  late final List<dynamic> likes;
  late final String image;
  late final List<dynamic> favouriteProduct;
  late final List<dynamic> favouriteCompany;
  late final String createdAt;
  late final bool active;
  late final String id;
  late final String updatedAt;
  late final int V;

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    username = json['username'];
    telephone = json['telephone'];
    role = json['role'];
    likes = List.castFrom<dynamic, dynamic>(json['likes']);
    image = json['image'];
    favouriteProduct =
        List.castFrom<dynamic, dynamic>(json['favouriteProduct']);
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany']);
    createdAt = json['createdAt'];
    active = json['active'];
    id = json['_id'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }
}
