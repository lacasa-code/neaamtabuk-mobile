
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
  int compete;
  int compete_store;
  int compete_docs;
  int complete;
  int declined;
  int rejected;
  String companyName;
  UserDetails userDetails;
  Images images;
  CommercialDocs commercialDocs;
  TaxCardDocs taxCardDocs;
  WholesaleDocs wholesaleDocs;
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
        this.images,
        this.commercialDocs,
        this.taxCardDocs,
        this.wholesaleDocs,
        this.bankDocs,
        this.compete,
        this.compete_docs,
        this.compete_store,
      });

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
    compete_docs = json['compete_docs'];
    compete_store = json['compete_store'];
    compete = json['complete'];
    companyName = json['company_name'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    commercialDocs = json['commercialDocs'] != null
        ? new CommercialDocs.fromJson(json['commercialDocs'])
        : null;
    taxCardDocs = json['taxCardDocs'] != null
        ? new TaxCardDocs.fromJson(json['taxCardDocs'])
        : null;
    wholesaleDocs = json['wholesaleDocs'] != null
        ? new WholesaleDocs.fromJson(json['wholesaleDocs'])
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
  String createdAt;
  String updatedAt;
  Null deletedAt;
  int addedById;
  String lang;
  String lastName;
  String phoneNo;
  String birthdate;
  String gender;
  Null facebookId;
  Null facebookAvatar;
  List<Roles> roles;

  UserDetails(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.addedById,
        this.lang,
        this.lastName,
        this.phoneNo,
        this.birthdate,
        this.gender,
        this.facebookId,
        this.facebookAvatar,
        this.roles});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    addedById = json['added_by_id'];
    lang = json['lang'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    facebookId = json['facebook_id'];
    facebookAvatar = json['facebook_avatar'];
    if (json['roles'] != null) {
      roles = new List<Roles>();
      json['roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['added_by_id'] = this.addedById;
    data['lang'] = this.lang;
    data['last_name'] = this.lastName;
    data['phone_no'] = this.phoneNo;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['facebook_id'] = this.facebookId;
    data['facebook_avatar'] = this.facebookAvatar;
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int id;
  String title;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  int addedById;
  String lang;
  Pivot pivot;

  Roles(
      {this.id,
        this.title,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.addedById,
        this.lang,
        this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    addedById = json['added_by_id'];
    lang = json['lang'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['added_by_id'] = this.addedById;
    data['lang'] = this.lang;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int userId;
  int roleId;

  Pivot({this.userId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    return data;
  }
}

class Images {
  int id;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String file_name;
  String preview;

  Images(
      {this.id,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.url,
        this.fullurl,
        this.file_name,
        this.preview});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    file_name = json['file_name'];
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
    data['thumbnail'] = this.file_name;
    data['preview'] = this.preview;
    return data;
  }
}

class CommercialDocs {
  int id;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String file_name;
  String preview;

  CommercialDocs(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.url,
        this.fullurl,
        this.file_name,
        this.preview});

  CommercialDocs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    file_name = json['file_name'];
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
    data['thumbnail'] = this.file_name;
    data['preview'] = this.preview;
    return data;
  }
}

class TaxCardDocs {
  int id;
  String modelType;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String file_name;
  String preview;

  TaxCardDocs(
      {this.id,
        this.modelType,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.url,
        this.fullurl,
        this.file_name,
        this.preview});

  TaxCardDocs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    file_name = json['file_name'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['url'] = this.url;
    data['fullurl'] = this.fullurl;
    data['thumbnail'] = this.file_name;
    data['preview'] = this.preview;
    return data;
  }
}

class WholesaleDocs {
  int id;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String file_name;
  String preview;

  WholesaleDocs(
      {this.id,
        this.updatedAt,
        this.image,
        this.url,
        this.fullurl,
        this.file_name,
        this.preview});

  WholesaleDocs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    file_name = json['file_name'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['url'] = this.url;
    data['fullurl'] = this.fullurl;
    data['thumbnail'] = this.file_name;
    data['preview'] = this.preview;
    return data;
  }
}
