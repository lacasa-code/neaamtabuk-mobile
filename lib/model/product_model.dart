class Product_model {
  int statusCode;
  String message;
  List<Products> data;
  int total;

  Product_model({this.statusCode, this.message, this.data, this.total});

  Product_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Products>();
      json['data'].forEach((v) {
        data.add(new Products.fromJson(v));
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

class Products {
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
  int cartypeId;
  String cartypeName;
  int countViews;
  List<Photo> photo;
  String timeCreated;

  Products(
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
      this.cartypeId,
      this.cartypeName,
      this.countViews,
      this.photo,
      this.timeCreated});

  Products.fromJson(Map<String, dynamic> json) {
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
    carModelName = json['car_model_name'];
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
    cartypeId = json['cartype_id'];
    cartypeName = json['cartype_name'];
    countViews = json['count_views'];
    if (json['photo'] != null) {
      photo = new List<Photo>();
      json['photo'].forEach((v) {
        photo.add(new Photo.fromJson(v));
      });
    }
    timeCreated = json['time_created'];
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
    data['cartype_id'] = this.cartypeId;
    data['cartype_name'] = this.cartypeName;
    data['count_views'] = this.countViews;
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    data['time_created'] = this.timeCreated;
    return data;
  }
}

class Photo {
  int id;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
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
      this.modelId,
      this.uuid,
      this.collectionName,
      this.name,
      this.fileName,
      this.mimeType,
      this.disk,
      this.conversionsDisk,
      this.size,
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
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
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
    data['model_id'] = this.modelId;
    data['uuid'] = this.uuid;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['conversions_disk'] = this.conversionsDisk;
    data['size'] = this.size;
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
