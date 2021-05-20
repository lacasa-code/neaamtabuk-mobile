class Ads_model {
  int statusCode;
  String message;
  List<Ads> data;

  Ads_model({this.statusCode, this.message, this.data});

  Ads_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Ads>();
      json['data'].forEach((v) {
        data.add(new Ads.fromJson(v));
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

class Ads {
  int id;
  String adName;
  int adPosition;
  String adUrl;
  int cartypeId;
  Photo photo;
  CarTypeAds carType;
  AdvPosition advPosition;

  Ads(
      {this.id,
        this.adName,
        this.adPosition,
        this.adUrl,
        this.cartypeId,
        this.photo,
        this.carType,
        this.advPosition});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adName = json['ad_name'];
    adPosition = json['ad_position'];
    adUrl = json['ad_url'];
    cartypeId = json['cartype_id'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    carType = json['car_type'] != null
        ? new CarTypeAds.fromJson(json['car_type'])
        : null;
    advPosition = json['adv_position'] != null
        ? new AdvPosition.fromJson(json['adv_position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ad_name'] = this.adName;
    data['ad_position'] = this.adPosition;
    data['ad_url'] = this.adUrl;
    data['cartype_id'] = this.cartypeId;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    if (this.carType != null) {
      data['car_type'] = this.carType.toJson();
    }
    if (this.advPosition != null) {
      data['adv_position'] = this.advPosition.toJson();
    }
    return data;
  }
}

class Photo {
  int id;
  String modelType;
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
  String preview;
  String image;

  Photo(
      {this.id,
        this.modelType,
        this.modelId,
        this.uuid,
        this.collectionName,
        this.name,
        this.image,
        this.fileName,
        this.mimeType,
        this.disk,
        this.conversionsDisk,
        this.size,
        this.orderColumn,
        this.preview});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    image = json['image'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
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
    data['preview'] = this.preview;
    return data;
  }
}

class CarTypeAds {
  int id;
  String typeName;
  String lang;
  int status;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  CarTypeAds(
      {this.id,
        this.typeName,
        this.lang,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  CarTypeAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    lang = json['lang'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['lang'] = this.lang;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class AdvPosition {
  int id;
  String positionName;
  int status;
  String lang;
  String createdAt;


  AdvPosition(
      {this.id,
        this.positionName,
        this.status,
        this.lang,
        this.createdAt});

  AdvPosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionName = json['position_name'];
    status = json['status'];
    lang = json['lang'];
    createdAt = json['created_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position_name'] = this.positionName;
    data['status'] = this.status;
    data['lang'] = this.lang;
    data['created_at'] = this.createdAt;

    return data;
  }
}
