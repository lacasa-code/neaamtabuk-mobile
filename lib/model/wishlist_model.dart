class Wishlist_model {
  int statusCode;
  String message;
  List<WishListItem> data;
  int total;

  Wishlist_model({this.statusCode, this.message, this.data, this.total});

  Wishlist_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<WishListItem>();
      json['data'].forEach((v) {
        data.add(new WishListItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class WishListItem {
  int id;
  int userId;
  int productId;
  String name;
  String description;
  String discount;
  String price;
  int quantity;
  String serialNumber;
  int carMadeId;
  String carMadeName;
  int carModelId;
  String carModelName;
  int cartypeId;
  String cartypeName;
  int yearId;
  String yearName;
  int partCategoryId;
  String partCategoryName;
  int categoryId;
  String categoryName;
  int vendorId;
  String vendorName;
  int storeId;
  String storeName;
  int manufacturerId;
  int prodcountryId;
  String manufacturerName;
  int transmissionId;
  String transmissionName;
  String origincountryName;
  int countViews;
  String avgValuations;
  int cartEnable;
  int wishlistEnable;
  List<Photo> photo;
  int countAvgValuations;
  String userName;
  String productName;
  String timeCreated;

  WishListItem(
      {this.id,
        this.userId,
        this.productId,
        this.name,
        this.description,
        this.discount,
        this.price,
        this.quantity,
        this.serialNumber,
        this.carMadeId,
        this.carMadeName,
        this.carModelId,
        this.carModelName,
        this.cartypeId,
        this.cartypeName,
        this.yearId,
        this.yearName,
        this.partCategoryId,
        this.partCategoryName,
        this.categoryId,
        this.categoryName,
        this.vendorId,
        this.vendorName,
        this.storeId,
        this.storeName,
        this.manufacturerId,
        this.prodcountryId,
        this.manufacturerName,
        this.transmissionId,
        this.transmissionName,
        this.origincountryName,
        this.countViews,
        this.avgValuations,
        this.cartEnable,
        this.wishlistEnable,
        this.photo,
        this.countAvgValuations,
        this.userName,
        this.productName,
        this.timeCreated});

  WishListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    name = json['name'];
    description = json['description'];
    discount = json['discount'];
    price = json['price'];
    quantity = json['quantity'];
    serialNumber = json['serial_number'];
    carMadeId = json['car_made_id'];
    carMadeName = json['car_made_name'];
    carModelId = json['car_model_id'];
    carModelName = json['car_model_name'];
    cartypeId = json['cartype_id'];
    cartypeName = json['cartype_name'];
    yearId = json['year_id'];
    yearName = json['year_name'];
    partCategoryId = json['part_category_id'];
    partCategoryName = json['part_category_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    manufacturerId = json['manufacturer_id'];
    prodcountryId = json['prodcountry_id'];
    manufacturerName = json['manufacturer_name'];
    transmissionId = json['transmission_id'];
    transmissionName = json['transmission_name'];
    origincountryName = json['origincountry_name'];
    countViews = json['count_views'];
    avgValuations = json['avg_valuations'];
    cartEnable = json['cart_enable'];
    wishlistEnable = json['wishlist_enable'];
    if (json['photo'] != null) {
      photo = new List<Photo>();
      json['photo'].forEach((v) {
        photo.add(new Photo.fromJson(v));
      });
    }
    countAvgValuations = json['count_avg_valuations'];
    userName = json['user_name'];
    productName = json['product_name'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['serial_number'] = this.serialNumber;
    data['car_made_id'] = this.carMadeId;
    data['car_made_name'] = this.carMadeName;
    data['car_model_id'] = this.carModelId;
    data['car_model_name'] = this.carModelName;
    data['cartype_id'] = this.cartypeId;
    data['cartype_name'] = this.cartypeName;
    data['year_id'] = this.yearId;
    data['year_name'] = this.yearName;
    data['part_category_id'] = this.partCategoryId;
    data['part_category_name'] = this.partCategoryName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['manufacturer_id'] = this.manufacturerId;
    data['prodcountry_id'] = this.prodcountryId;
    data['manufacturer_name'] = this.manufacturerName;
    data['transmission_id'] = this.transmissionId;
    data['transmission_name'] = this.transmissionName;
    data['origincountry_name'] = this.origincountryName;
    data['count_views'] = this.countViews;
    data['avg_valuations'] = this.avgValuations;
    data['cart_enable'] = this.cartEnable;
    data['wishlist_enable'] = this.wishlistEnable;
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    data['count_avg_valuations'] = this.countAvgValuations;
    data['user_name'] = this.userName;
    data['product_name'] = this.productName;
    data['time_created'] = this.timeCreated;
    return data;
  }
}

class Photo {
  int id;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String thumbnail;
  String preview;

  Photo(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.url,
        this.fullurl,
        this.thumbnail,
        this.preview});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    thumbnail = json['thumbnail'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['url'] = this.url;
    data['fullurl'] = this.fullurl;
    data['thumbnail'] = this.thumbnail;
    data['preview'] = this.preview;
    return data;
  }
}
