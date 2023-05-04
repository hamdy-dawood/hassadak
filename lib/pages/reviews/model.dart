class ReviewsResponse {
  ReviewsResponse({
    required this.status,
    required this.results,
    required this.data,
  });

  late final String status;
  late final int results;
  late final Data data;

  ReviewsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    required this.doc,
  });

  late final List<Doc> doc;

  Data.fromJson(Map<String, dynamic> json) {
    doc = List.from(json['doc']).map((e) => Doc.fromJson(e)).toList();
  }
}

class Doc {
  Doc({
    required this.review,
    required this.rating,
    required this.createdAt,
    required this.product,
    required this.user,
    required this.updatedAt,
    required this.id,
  });

  late final String review;
  late final int rating;
  late final String createdAt;
  late final String product;
  late final User user;
  late final String updatedAt;
  late final String id;

  Doc.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    product = json['product'];
    user = User.fromJson(json['user']);
    updatedAt = json['updatedAt'];
    id = json['id'];
  }
}

class User {
  User({
    required this.id,
  });

  late final String id;

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
  }
}
