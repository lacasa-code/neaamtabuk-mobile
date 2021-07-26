class Review_model {
  int statusCode;
  String message;
  Reviews data;

  Review_model({this.statusCode, this.message, this.data});

  Review_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Reviews.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Reviews {
  List<ReviewsData> reviewsData;
  int reviewsCount;
  int evaluationsCount;
  String avgValuations;

  Reviews(
      {this.reviewsData,
        this.reviewsCount,
        this.evaluationsCount,
        this.avgValuations});

  Reviews.fromJson(Map<String, dynamic> json) {
    if (json['reviews_data'] != null) {
      reviewsData = new List<ReviewsData>();
      json['reviews_data'].forEach((v) {
        reviewsData.add(new ReviewsData.fromJson(v));
      });
    }
    reviewsCount = json['reviews_count'];
    evaluationsCount = json['evaluations_count'];
    avgValuations = json['avg_valuations'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviewsData != null) {
      data['reviews_data'] = this.reviewsData.map((v) => v.toJson()).toList();
    }
    data['reviews_count'] = this.reviewsCount;
    data['evaluations_count'] = this.evaluationsCount;
    data['avg_valuations'] = this.avgValuations;
    return data;
  }
}

class ReviewsData {
  int id;
  String bodyReview;
  int userId;
  int productId;
  String userName;
  String productName;
  double evaluationValue;
  String createdAt;
  String timeCreated;

  ReviewsData(
      {this.id,
        this.bodyReview,
        this.userId,
        this.productId,
        this.userName,
        this.productName,
        this.evaluationValue,
        this.createdAt,
        this.timeCreated});

  ReviewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bodyReview = json['body_review'];
    userId = json['user_id'];
    productId = json['product_id'];
    userName = json['user_name'];
    productName = json['product_name'];
     evaluationValue = double.parse(json['evaluation_value'].toString());
    createdAt = json['created_at'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body_review'] = this.bodyReview;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['user_name'] = this.userName;
    data['product_name'] = this.productName;
    data['evaluation_value'] = this.evaluationValue;
    data['created_at'] = this.createdAt;
    data['time_created'] = this.timeCreated;
    return data;
  }
}
