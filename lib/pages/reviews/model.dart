class ReviewsResponse {
  ReviewsResponse({
    this.status,
    this.results,
    this.data,
  });

  String? status;
  int? results;
  Data? data;

  // ReviewsResponse.fromJson(Map<String, dynamic> json) {
  //   status = json['status'] ?? "";
  //   results = json['results'] ?? "";
  //   data = Data.fromJson(json['data'] ?? "");
  // }

  ReviewsResponse.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'] ?? "";
      results = json['results'] ?? 0;
      data = Data.fromJson(json['data'] as Map<String, dynamic>);
    }
  }
}

class Data {
  Data({
    this.doc,
  });

  List<Doc>? doc;

  // Data.fromJson(Map<String, dynamic> json) {
  //   doc = List.from(json['doc'] ?? []).map((e) => Doc.fromJson(e)).toList();
  // }
  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      doc = List.from(json['doc'] ?? [])
          .map((e) => Doc.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }
}

class Doc {
  Doc({
    this.review,
    this.rating,
    this.createdAt,
    this.product,
    this.user,
    this.updatedAt,
    this.id,
    this.userName,
    this.image,
  });

  String? review;
  int? rating;
  String? createdAt;
  String? product;
  User? user;
  String? updatedAt;
  String? id;
  String? userName;
  String? image;

  Doc.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      review = json['review'] ?? "";
      rating = json['rating'] ?? 0;
      createdAt = json['createdAt'] ?? "";
      product = json['product'] ?? "";
      user = User.fromJson(json['user'] as Map<String, dynamic>);
      updatedAt = json['updatedAt'] ?? "";
      id = json['id'] ?? "";
      userName = json['userName'] ?? "";
      image = json['image'] ?? "";
    }
  }
}

class User {
  User({
    this.id,
  });

  String? id;

  // User.fromJson(Map<String, dynamic> json) {
  //   id = json['_id'] ?? "";
  // }

  User.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['_id'] ?? "";
    }
  }
}
