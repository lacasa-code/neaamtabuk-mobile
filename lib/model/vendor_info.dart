/// status_code : 200
/// message : "succcess"
/// data : {"id":2,"vendor_name":"second vendor","email":"seconduser@example.com","type":"1","serial":"V002","created_at":"2021-03-09 14:24:50","updated_at":"2021-06-08 12:04:44","userid_id":2,"lang":"ar","commercial_no":"323123","commercial_doc":"","tax_card_no":"13123","tax_card_doc":"","bank_account":"321321","approved":1,"complete":0,"declined":0,"rejected":0,"company_name":"null","images":{"id":237,"model_id":2,"uuid":"34639590-2223-48eb-bb4d-e08ef2fef46b","collection_name":"images","name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV","file_name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","mime_type":"image/jpeg","disk":"public","conversions_disk":"public","size":130009,"order_column":232,"created_at":"2021-06-08T11:49:34.000000Z","updated_at":"2021-06-08T11:49:35.000000Z","image":"https://traker.fra1.digitaloceanspaces.com/add-vendors/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","url":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","fullurl":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","thumbnail":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-thumb.jpg","preview":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-preview.jpg"},"media":[{"id":237,"model_id":2,"uuid":"34639590-2223-48eb-bb4d-e08ef2fef46b","collection_name":"images","name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV","file_name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","mime_type":"image/jpeg","disk":"public","conversions_disk":"public","size":130009,"order_column":232,"created_at":"2021-06-08T11:49:34.000000Z","updated_at":"2021-06-08T11:49:35.000000Z","image":"https://traker.fra1.digitaloceanspaces.com/add-vendors/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","url":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","fullurl":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","thumbnail":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-thumb.jpg","preview":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-preview.jpg"}]}

class Vendor_info {
  int _statusCode;
  String _message;
  Vendor _data;

  int get statusCode => _statusCode;
  String get message => _message;
  Vendor get data => _data;

  Vendor_info({
      int statusCode, 
      String message, 
      Vendor data}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  Vendor_info.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    _data = json["data"] != null ? Vendor.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// id : 2
/// vendor_name : "second vendor"
/// email : "seconduser@example.com"
/// type : "1"
/// serial : "V002"
/// created_at : "2021-03-09 14:24:50"
/// updated_at : "2021-06-08 12:04:44"
/// userid_id : 2
/// lang : "ar"
/// commercial_no : "323123"
/// commercial_doc : ""
/// tax_card_no : "13123"
/// tax_card_doc : ""
/// bank_account : "321321"
/// approved : 1
/// complete : 0
/// declined : 0
/// rejected : 0
/// company_name : "null"
/// images : {"id":237,"model_id":2,"uuid":"34639590-2223-48eb-bb4d-e08ef2fef46b","collection_name":"images","name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV","file_name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","mime_type":"image/jpeg","disk":"public","conversions_disk":"public","size":130009,"order_column":232,"created_at":"2021-06-08T11:49:34.000000Z","updated_at":"2021-06-08T11:49:35.000000Z","image":"https://traker.fra1.digitaloceanspaces.com/add-vendors/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","url":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","fullurl":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","thumbnail":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-thumb.jpg","preview":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-preview.jpg"}
/// media : [{"id":237,"model_id":2,"uuid":"34639590-2223-48eb-bb4d-e08ef2fef46b","collection_name":"images","name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV","file_name":"SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","mime_type":"image/jpeg","disk":"public","conversions_disk":"public","size":130009,"order_column":232,"created_at":"2021-06-08T11:49:34.000000Z","updated_at":"2021-06-08T11:49:35.000000Z","image":"https://traker.fra1.digitaloceanspaces.com/add-vendors/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","url":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","fullurl":"https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg","thumbnail":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-thumb.jpg","preview":"https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-preview.jpg"}]

class Vendor {
  int _id;
  String _vendorName;
  String _email;
  String _phone_no;
  String _type;
  String _serial;
  String _createdAt;
  String _updatedAt;
  int _useridId;
  String _lang;
  String _commercialNo;
  String _commercialDoc;
  String _taxCardNo;
  String _taxCardDoc;
  String _bankAccount;
  int _approved;
  int _complete;
  int _declined;
  int _rejected;

  set id(int value) {
    _id = value;
  }

  String _companyName;
  Images _images;
  List<Media> _media;

  int get id => _id;
  String get vendorName => _vendorName;
  String get email => _email;
  String get type => _type;
  String get phone_no => _phone_no;
  String get serial => _serial;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get useridId => _useridId;
  String get lang => _lang;
  String get commercialNo => _commercialNo;
  String get commercialDoc => _commercialDoc;
  String get taxCardNo => _taxCardNo;
  String get taxCardDoc => _taxCardDoc;
  String get bankAccount => _bankAccount;
  int get approved => _approved;
  int get complete => _complete;
  int get declined => _declined;
  int get rejected => _rejected;
  String get companyName => _companyName;
  Images get images => _images;
  List<Media> get media => _media;

  Vendor({
      int id, 
      String vendorName, 
      String email, 
      String phone_no,
      String type,
      String serial, 
      String createdAt, 
      String updatedAt, 
      int useridId, 
      String lang, 
      String commercialNo, 
      String commercialDoc, 
      String taxCardNo, 
      String taxCardDoc, 
      String bankAccount, 
      int approved, 
      int complete, 
      int declined, 
      int rejected, 
      String companyName, 
      Images images, 
      List<Media> media}){
    _id = id;
    _vendorName = vendorName;
    _email = email;
    _type = type;
    _serial = serial;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _useridId = useridId;
    _lang = lang;
    _commercialNo = commercialNo;
    _commercialDoc = commercialDoc;
    _taxCardNo = taxCardNo;
    _taxCardDoc = taxCardDoc;
    _bankAccount = bankAccount;
    _approved = approved;
    _phone_no = phone_no;
    _complete = complete;
    _declined = declined;
    _rejected = rejected;
    _companyName = companyName;
    _images = images;
    _media = media;
}

  Vendor.fromJson(dynamic json) {
    _id = json["id"];
    _vendorName = json["vendor_name"];
    _email = json["email"];
    _phone_no = json["phone_no"];
    _type = json["type"];
    _serial = json["serial"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _useridId = json["userid_id"];
    _lang = json["lang"];
    _commercialNo = json["commercial_no"];
    _commercialDoc = json["commercial_doc"];
    _taxCardNo = json["tax_card_no"];
    _taxCardDoc = json["tax_card_doc"];
    _bankAccount = json["bank_account"];
    _approved = json["approved"];
    _complete = json["complete"];
    _declined = json["declined"];
    _rejected = json["rejected"];
    _companyName = json["company_name"];
    _images = json["images"] != null ? Images.fromJson(json["images"]) : null;
    if (json["media"] != null) {
      _media = [];
      json["media"].forEach((v) {
        _media.add(Media.fromJson(v));
      });
    }
  }

  Map<String, String> toJson() {
    var map = <String, String>{};
    map["vendor_id"] = _id.toString();
    map["userid_id"] = _useridId.toString();
    map["vendor_name"] = _vendorName;
    map["commercial_no"] = _commercialNo;
    //map["commercial_doc"] = _commercialDoc;
    map["tax_card_no"] = _taxCardNo;
    map["tax_card_doc"] = _taxCardDoc;
    map["bank_account"] = _bankAccount;
    map["type"] = _type;
    map["email"] = _email;
    map["serial"] = _serial;
    map["phone_no"] = _phone_no;
    map["lang"] = _lang;
    map["company_name"] = _companyName;
    return map;
  }

  set vendorName(String value) {
    _vendorName = value;
  }

  set email(String value) {
    _email = value;
  }
set phone_no(String value) {
    _phone_no = value;
  }

  set type(String value) {
    _type = value;
  }

  set serial(String value) {
    _serial = value;
  }

  set createdAt(String value) {
    _createdAt = value;
  }

  set updatedAt(String value) {
    _updatedAt = value;
  }

  set useridId(int value) {
    _useridId = value;
  }

  set lang(String value) {
    _lang = value;
  }

  set commercialNo(String value) {
    _commercialNo = value;
  }

  set commercialDoc(String value) {
    _commercialDoc = value;
  }

  set taxCardNo(String value) {
    _taxCardNo = value;
  }

  set taxCardDoc(String value) {
    _taxCardDoc = value;
  }

  set bankAccount(String value) {
    _bankAccount = value;
  }

  set approved(int value) {
    _approved = value;
  }

  set complete(int value) {
    _complete = value;
  }

  set declined(int value) {
    _declined = value;
  }

  set rejected(int value) {
    _rejected = value;
  }

  set companyName(String value) {
    _companyName = value;
  }

  set images(Images value) {
    _images = value;
  }

  set media(List<Media> value) {
    _media = value;
  }
}

/// id : 237
/// model_id : 2
/// uuid : "34639590-2223-48eb-bb4d-e08ef2fef46b"
/// collection_name : "images"
/// name : "SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV"
/// file_name : "SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// mime_type : "image/jpeg"
/// disk : "public"
/// conversions_disk : "public"
/// size : 130009
/// order_column : 232
/// created_at : "2021-06-08T11:49:34.000000Z"
/// updated_at : "2021-06-08T11:49:35.000000Z"
/// image : "https://traker.fra1.digitaloceanspaces.com/add-vendors/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// url : "https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// fullurl : "https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// thumbnail : "https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-thumb.jpg"
/// preview : "https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-preview.jpg"

class Media {
  int _id;
  int _modelId;
  String _uuid;
  String _collectionName;
  String _name;
  String _fileName;
  String _mimeType;
  String _disk;
  String _conversionsDisk;
  int _size;
  int _orderColumn;
  String _createdAt;
  String _updatedAt;
  String _image;
  String _url;
  String _fullurl;
  String _thumbnail;
  String _preview;

  int get id => _id;
  int get modelId => _modelId;
  String get uuid => _uuid;
  String get collectionName => _collectionName;
  String get name => _name;
  String get fileName => _fileName;
  String get mimeType => _mimeType;
  String get disk => _disk;
  String get conversionsDisk => _conversionsDisk;
  int get size => _size;
  int get orderColumn => _orderColumn;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get image => _image;
  String get url => _url;
  String get fullurl => _fullurl;
  String get thumbnail => _thumbnail;
  String get preview => _preview;

  Media({
      int id, 
      int modelId, 
      String uuid, 
      String collectionName, 
      String name, 
      String fileName, 
      String mimeType, 
      String disk, 
      String conversionsDisk, 
      int size, 
      int orderColumn, 
      String createdAt, 
      String updatedAt, 
      String image, 
      String url, 
      String fullurl, 
      String thumbnail, 
      String preview}){
    _id = id;
    _modelId = modelId;
    _uuid = uuid;
    _collectionName = collectionName;
    _name = name;
    _fileName = fileName;
    _mimeType = mimeType;
    _disk = disk;
    _conversionsDisk = conversionsDisk;
    _size = size;
    _orderColumn = orderColumn;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
    _url = url;
    _fullurl = fullurl;
    _thumbnail = thumbnail;
    _preview = preview;
}

  Media.fromJson(dynamic json) {
    _id = json["id"];
    _modelId = json["model_id"];
    _uuid = json["uuid"];
    _collectionName = json["collection_name"];
    _name = json["name"];
    _fileName = json["file_name"];
    _mimeType = json["mime_type"];
    _disk = json["disk"];
    _conversionsDisk = json["conversions_disk"];
    _size = json["size"];
    _orderColumn = json["order_column"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _image = json["image"];
    _url = json["url"];
    _fullurl = json["fullurl"];
    _thumbnail = json["thumbnail"];
    _preview = json["preview"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["model_id"] = _modelId;
    map["uuid"] = _uuid;
    map["collection_name"] = _collectionName;
    map["name"] = _name;
    map["file_name"] = _fileName;
    map["mime_type"] = _mimeType;
    map["disk"] = _disk;
    map["conversions_disk"] = _conversionsDisk;
    map["size"] = _size;
    map["order_column"] = _orderColumn;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["image"] = _image;
    map["url"] = _url;
    map["fullurl"] = _fullurl;
    map["thumbnail"] = _thumbnail;
    map["preview"] = _preview;
    return map;
  }

}

/// id : 237
/// model_id : 2
/// uuid : "34639590-2223-48eb-bb4d-e08ef2fef46b"
/// collection_name : "images"
/// name : "SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV"
/// file_name : "SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// mime_type : "image/jpeg"
/// disk : "public"
/// conversions_disk : "public"
/// size : 130009
/// order_column : 232
/// created_at : "2021-06-08T11:49:34.000000Z"
/// updated_at : "2021-06-08T11:49:35.000000Z"
/// image : "https://traker.fra1.digitaloceanspaces.com/add-vendors/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// url : "https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// fullurl : "https://development.lacasacode.dev/storage/237/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV.jpg"
/// thumbnail : "https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-thumb.jpg"
/// preview : "https://development.lacasacode.dev/storage/237/conversions/SJpIpzunzPisAfihtfKPT29QW3EgmGPumLehZHbV-preview.jpg"

class Images {
  int _id;
  int _modelId;
  String _uuid;
  String _collectionName;
  String _name;
  String _fileName;
  String _mimeType;
  String _disk;
  String _conversionsDisk;
  int _size;
  int _orderColumn;
  String _createdAt;
  String _updatedAt;
  String _image;
  String _url;
  String _fullurl;
  String _thumbnail;
  String _preview;

  int get id => _id;
  int get modelId => _modelId;
  String get uuid => _uuid;
  String get collectionName => _collectionName;
  String get name => _name;
  String get fileName => _fileName;
  String get mimeType => _mimeType;
  String get disk => _disk;
  String get conversionsDisk => _conversionsDisk;
  int get size => _size;
  int get orderColumn => _orderColumn;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get image => _image;
  String get url => _url;
  String get fullurl => _fullurl;
  String get thumbnail => _thumbnail;
  String get preview => _preview;

  Images({
      int id, 
      int modelId, 
      String uuid, 
      String collectionName, 
      String name, 
      String fileName, 
      String mimeType, 
      String disk, 
      String conversionsDisk, 
      int size, 
      int orderColumn, 
      String createdAt, 
      String updatedAt, 
      String image, 
      String url, 
      String fullurl, 
      String thumbnail, 
      String preview}){
    _id = id;
    _modelId = modelId;
    _uuid = uuid;
    _collectionName = collectionName;
    _name = name;
    _fileName = fileName;
    _mimeType = mimeType;
    _disk = disk;
    _conversionsDisk = conversionsDisk;
    _size = size;
    _orderColumn = orderColumn;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
    _url = url;
    _fullurl = fullurl;
    _thumbnail = thumbnail;
    _preview = preview;
}

  Images.fromJson(dynamic json) {
    _id = json["id"];
    _modelId = json["model_id"];
    _uuid = json["uuid"];
    _collectionName = json["collection_name"];
    _name = json["name"];
    _fileName = json["file_name"];
    _mimeType = json["mime_type"];
    _disk = json["disk"];
    _conversionsDisk = json["conversions_disk"];
    _size = json["size"];
    _orderColumn = json["order_column"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _image = json["image"];
    _url = json["url"];
    _fullurl = json["fullurl"];
    _thumbnail = json["thumbnail"];
    _preview = json["preview"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["model_id"] = _modelId;
    map["uuid"] = _uuid;
    map["collection_name"] = _collectionName;
    map["name"] = _name;
    map["file_name"] = _fileName;
    map["mime_type"] = _mimeType;
    map["disk"] = _disk;
    map["conversions_disk"] = _conversionsDisk;
    map["size"] = _size;
    map["order_column"] = _orderColumn;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["image"] = _image;
    map["url"] = _url;
    map["fullurl"] = _fullurl;
    map["thumbnail"] = _thumbnail;
    map["preview"] = _preview;
    return map;
  }

}