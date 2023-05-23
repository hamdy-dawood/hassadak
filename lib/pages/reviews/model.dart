import 'package:hassadak/constants/strings.dart';

class ReviewsResponse {
  String? status;
  int? results;
  List<Doc>? doc;

  ReviewsResponse({this.status, this.results, this.doc});

  ReviewsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    results = json['results'] ?? 0;
    if (json['doc'] != null) {
      doc = <Doc>[];
      json['doc'].forEach((v) {
        doc!.add(Doc.fromJson(v));
      });
    }
  }
}

class Doc {
  String? review;
  int? rating;
  String? createdAt;
  String? product;
  User? user;
  String? updatedAt;
  String? userName;
  String? id;
  String? userPhoto;

  Doc(
      {this.review,
      this.rating,
      this.createdAt,
      this.product,
      this.user,
      this.updatedAt,
      this.userName,
      this.id,
      this.userPhoto});

  Doc.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    product = json['product'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    updatedAt = json['updatedAt'];
    userName = json['userName'];
    id = json['id'];
    userPhoto = json['userPhoto'] ?? UrlsStrings.noImageUrl;
  }
}

class User {
  String? sId;

  User({this.sId});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? Map<String, dynamic>;
  }
}
