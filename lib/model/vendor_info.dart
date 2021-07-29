class Vendor_info {
  int statusCode;
  String message;
  Vendor data;

  Vendor_info({this.statusCode, this.message, this.data});

  Vendor_info.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Vendor.fromJson(json['data']) : null;
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

class Vendor {
  int id;
  String vendorName;
  String email;
  String type;
  String serial;
  String createdAt;
  String updatedAt;
  int useridId;
  String lang;
  String commercialNo;
  String commercialDoc;
  String taxCardNo;
  String taxCardDoc;
  String bankAccount;
  int approved;
  int complete;
  int declined;
  int rejected;
  String companyName;
  UserDetails userDetails;
  String venType;
  int competeStore;
  StoreDetails storeDetails;
  int competeDocs;
  Images images;
  Images commercialDocs;
  Images taxCardDocs;
  Images wholesaleDocs;
  Images bankDocs;

  Vendor(
      {this.id,
        this.vendorName,
        this.email,
        this.type,
        this.serial,
        this.createdAt,
        this.updatedAt,
        this.useridId,
        this.lang,
        this.commercialNo,
        this.commercialDoc,
        this.taxCardNo,
        this.taxCardDoc,
        this.bankAccount,
        this.approved,
        this.complete,
        this.declined,
        this.rejected,
        this.companyName,
        this.userDetails,
        this.venType,
        this.competeStore,
        this.storeDetails,
        this.competeDocs,
        this.images,
        this.commercialDocs,
        this.taxCardDocs,
        this.wholesaleDocs,
        this.bankDocs});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendor_name'];
    email = json['email'];
    type = json['type'];
    serial = json['serial'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    useridId = json['userid_id'];
    lang = json['lang'];
    commercialNo = json['commercial_no'];
    commercialDoc = json['commercial_doc'];
    taxCardNo = json['tax_card_no'];
    taxCardDoc = json['tax_card_doc'];
    bankAccount = json['bank_account'];
    approved = json['approved'];
    complete = json['complete'];
    declined = json['declined'];
    rejected = json['rejected'];
    companyName = json['company_name'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    venType = json['ven_type'];
    competeStore = json['compete_store'];
    storeDetails = json['store_details'] != null
        ? new StoreDetails.fromJson(json['store_details'])
        : null;
    competeDocs = json['compete_docs'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    commercialDocs = json['commercialDocs'] != null
        ? new Images.fromJson(json['commercialDocs'])
        : null;
    taxCardDocs = json['taxCardDocs'] != null
        ? new Images.fromJson(json['taxCardDocs'])
        : null;
    wholesaleDocs = json['wholesaleDocs'] != null
        ? new Images.fromJson(json['wholesaleDocs'])
        : null;
    bankDocs =
    json['bankDocs'] != null ? new Images.fromJson(json['bankDocs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_name'] = this.vendorName;
    data['email'] = this.email;
    data['type'] = this.type;
    data['serial'] = this.serial;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['userid_id'] = this.useridId;
    data['lang'] = this.lang;
    data['commercial_no'] = this.commercialNo;
    data['commercial_doc'] = this.commercialDoc;
    data['tax_card_no'] = this.taxCardNo;
    data['tax_card_doc'] = this.taxCardDoc;
    data['bank_account'] = this.bankAccount;
    data['approved'] = this.approved;
    data['complete'] = this.complete;
    data['declined'] = this.declined;
    data['rejected'] = this.rejected;
    data['company_name'] = this.companyName;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.toJson();
    }
    data['ven_type'] = this.venType;
    data['compete_store'] = this.competeStore;
    if (this.storeDetails != null) {
      data['store_details'] = this.storeDetails.toJson();
    }
    data['compete_docs'] = this.competeDocs;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    if (this.commercialDocs != null) {
      data['commercialDocs'] = this.commercialDocs.toJson();
    }
    if (this.taxCardDocs != null) {
      data['taxCardDocs'] = this.taxCardDocs.toJson();
    }
    if (this.wholesaleDocs != null) {
      data['wholesaleDocs'] = this.wholesaleDocs.toJson();
    }
    if (this.bankDocs != null) {
      data['bankDocs'] = this.bankDocs.toJson();
    }
    return data;
  }
}

class UserDetails {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  int addedById;
  String lang;
  String lastName;
  String phoneNo;
  String birthdate;
  String gender;
  String facebookId;
  String facebookAvatar;

  UserDetails(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.addedById,
        this.lang,
        this.lastName,
        this.phoneNo,
        this.birthdate,
        this.gender,
        this.facebookId,
        this.facebookAvatar});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    addedById = json['added_by_id'];
    lang = json['lang'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    facebookId = json['facebook_id'];
    facebookAvatar = json['facebook_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['added_by_id'] = this.addedById;
    data['lang'] = this.lang;
    data['last_name'] = this.lastName;
    data['phone_no'] = this.phoneNo;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['facebook_id'] = this.facebookId;
    data['facebook_avatar'] = this.facebookAvatar;
    return data;
  }
}

class StoreDetails {
  int id;
  String name;
  String address;
  String lat;
  String long;
  int vendorId;
  String moderatorName;
  String moderatorPhone;
  String moderatorAltPhone;
  int status;
  String lang;
  int headCenter;
  int countryId;
  int areaId;
  int cityId;
  String serialId;

  StoreDetails(
      {this.id,
        this.name,
        this.address,
        this.lat,
        this.long,
        this.vendorId,
        this.moderatorName,
        this.moderatorPhone,
        this.moderatorAltPhone,
        this.status,
        this.lang,
        this.headCenter,
        this.countryId,
        this.areaId,
        this.cityId,
        this.serialId});

  StoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    vendorId = json['vendor_id'];
    moderatorName = json['moderator_name'];
    moderatorPhone = json['moderator_phone'];
    moderatorAltPhone = json['moderator_alt_phone'];
    status = json['status'];
    lang = json['lang'];
    headCenter = json['head_center'];
    countryId = json['country_id'];
    areaId = json['area_id'];
    cityId = json['city_id'];
    serialId = json['serial_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['vendor_id'] = this.vendorId;
    data['moderator_name'] = this.moderatorName;
    data['moderator_phone'] = this.moderatorPhone;
    data['moderator_alt_phone'] = this.moderatorAltPhone;
    data['status'] = this.status;
    data['lang'] = this.lang;
    data['head_center'] = this.headCenter;
    data['country_id'] = this.countryId;
    data['area_id'] = this.areaId;
    data['city_id'] = this.cityId;
    data['serial_id'] = this.serialId;
    return data;
  }
}

class Images {
  int id;
  int modelId;
  String image;
  String name;

  Images({this.id, this.modelId, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    image = json['image'];
    name = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['image'] = this.image;
    return data;
  }
}
