class Product_model {
  int statusCode;
  String message;
  List<Product> data;
  int total;

  Product_model({this.statusCode, this.message, this.data, this.total});

  Product_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Product>();
      json['data'].forEach((v) {
        data.add(new Product.fromJson(v));
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

class Product {
  int id;
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
  int producttypeId;
  String producttypeName;
  String origincountryName;
  int noOfOrders;
  String holesalePrice;
  int countViews;
  int cartEnable;
  int wishlistEnable;
  List<Photo> photo;
  List<ProductTags> productTags;
  int countProductReviews;
  int countAvgValuations;
  String timeCreated;
  int inCart;
  String inWishlist;
  int inFavourites;

  Product(
      {this.id,
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
        this.producttypeId,
        this.producttypeName,
        this.origincountryName,
        this.noOfOrders,
        this.holesalePrice,
        this.countViews,
        this.cartEnable,
        this.wishlistEnable,
        this.photo,
        this.productTags,
        this.countProductReviews,
        this.countAvgValuations,
        this.timeCreated,
        this.inCart,
        this.inWishlist,
        this.inFavourites});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    discount = json['discount'];
    price = json['price'];
    quantity = json['quantity'];
    serialNumber = json['serial_number'];
    carMadeId = json['car_made_id'];
    carMadeName = json['car_made_name'];
    carModelId = json['car_model_id'];
    carModelName = json['car_model_name'].toString();
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
    producttypeId = json['producttype_id'];
    producttypeName = json['producttype_name'];
    origincountryName = json['origincountry_name'];
    noOfOrders = json['no_of_orders'];
    holesalePrice = json['holesale_price'];
    countViews = json['count_views'];
    cartEnable = json['cart_enable'];
    wishlistEnable = json['wishlist_enable'];
    if (json['photo'] != null) {
      photo = new List<Photo>();
      json['photo'].forEach((v) {
        photo.add(new Photo.fromJson(v));
      });
    }
    if (json['product_tags'] != null) {
      productTags = new List<ProductTags>();
      json['product_tags'].forEach((v) {
        productTags.add(new ProductTags.fromJson(v));
      });
    }
    countProductReviews = json['count_product_reviews'];
    countAvgValuations = json['count_avg_valuations'];
    timeCreated = json['time_created'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'].toString();
    print(json['in_wishlist']);
    inFavourites = json['in_favourites'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['producttype_id'] = this.producttypeId;
    data['producttype_name'] = this.producttypeName;
    data['origincountry_name'] = this.origincountryName;
    data['no_of_orders'] = this.noOfOrders;
    data['holesale_price'] = this.holesalePrice;
    data['count_views'] = this.countViews;
    data['cart_enable'] = this.cartEnable;
    data['wishlist_enable'] = this.wishlistEnable;
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    if (this.productTags != null) {
      data['product_tags'] = this.productTags.map((v) => v.toJson()).toList();
    }
    data['count_product_reviews'] = this.countProductReviews;
    data['count_avg_valuations'] = this.countAvgValuations;
    data['time_created'] = this.timeCreated;
    data['in_cart'] = this.inCart;
    data['in_wishlist'] = this.inWishlist;
    data['in_favourites'] = this.inFavourites;
    return data;
  }
}

class Photo {
  int id;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String thumbnail;
  String preview;

  Photo(
      {this.id,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.url,
        this.fullurl,
        this.thumbnail,
        this.preview});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderColumn = json['order_column'];
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
    data['order_column'] = this.orderColumn;
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

class ProductTags {
  String name;
  String timeCreated;

  ProductTags({this.name, this.timeCreated});

  ProductTags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time_created'] = this.timeCreated;
    return data;
  }
}

