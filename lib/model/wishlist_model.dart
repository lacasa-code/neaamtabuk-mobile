class Wishlist_model {
  int statusCode;
  String message;
  List<WishListItem> data;

  Wishlist_model({this.statusCode, this.message, this.data});

  Wishlist_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<WishListItem>();
      json['data'].forEach((v) {
        data.add(new WishListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishListItem {
  int id;
  int userId;
  int productId;
  String userName;
  String product_price;
  String actual_price;
  double avg_valuations;
  String productName;
  List<Photo> photo;

  WishListItem(
      {this.id,
        this.userId,
        this.productId,
        this.userName,
        this.productName,
        this.photo});

  WishListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    userName = json['user_name'];
    productName = json['product_name'];
    actual_price = json['actual_price'].toString();
    avg_valuations = double.parse((json['avg_valuations']??'0').toString());
    product_price = json['product_price'].toString();
    if (json['photo'] != null) {
      photo = new List<Photo>();
      json['photo'].forEach((v) {
        photo.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['user_name'] = this.userName;
    data['product_name'] = this.productName;
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photo {
  int id;
  String image;
  String url;
  String fullurl;
  String thumbnail;
  String preview;

  Photo(
      {this.id,
        this.image,
        this.url,
        this.fullurl,
        this.thumbnail,
        this.preview});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    thumbnail = json['thumbnail'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['url'] = this.url;
    data['fullurl'] = this.fullurl;
    data['thumbnail'] = this.thumbnail;
    data['preview'] = this.preview;
    return data;
  }
}
