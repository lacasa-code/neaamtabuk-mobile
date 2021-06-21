

class Question_model {
  int _statusCode;
  String _message;
  List<Question> _data;
  int _total;
  int get statusCode => _statusCode;
  String get message => _message;
  List<Question> get data => _data;
  int get total => _total;

  Question_model({
      int statusCode, 
      String message, 
      List<Question> data, 
      int total}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _total = total;
}

  Question_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Question.fromJson(v));
      });
    }
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["total"] = _total;
    return map;
  }

}
class Question {
  int _id;
  int _userId;
  int _productId;
  int _vendorId;
  String _userName;
  Vendor _vendor;
  String _bodyQuestion;
  dynamic _answer;
  String _reply;
  String _lang;
  dynamic _status;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get userId => _userId;
  int get productId => _productId;
  int get vendorId => _vendorId;
  String get userName => _userName;
  Vendor get vendor => _vendor;
  String get bodyQuestion => _bodyQuestion;
  dynamic get answer => _answer;
  String get reply => _reply;
  String get lang => _lang;
  dynamic get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Question({
      int id, 
      int userId, 
      int productId, 
      int vendorId, 
      String userName, 
      Vendor vendor,
      String bodyQuestion, 
      dynamic answer, 
      String reply, 
      String lang, 
      dynamic status, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _userId = userId;
    _productId = productId;
    _vendorId = vendorId;
    _userName = userName;
    _vendor = vendor;
    _bodyQuestion = bodyQuestion;
    _answer = answer;
    _reply = reply;
    _lang = lang;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Question.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _productId = json["product_id"];
    _vendorId = json["vendor_id"];
    _userName = json["user_name"];
    _vendor = json["vendor"] != null ? Vendor.fromJson(json["vendor"]) : null;
    _bodyQuestion = json["body_question"];
    _answer = json["answer"];
    _reply = json["reply"];
    _lang = json["lang"];
    _status = json["status"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["product_id"] = _productId;
    map["vendor_id"] = _vendorId;
    map["user_name"] = _userName;

    if (_vendor != null) {
      map["vendor"] = _vendor.toJson();
    }
    map["body_question"] = _bodyQuestion;
    map["answer"] = _answer;
    map["reply"] = _reply;
    map["lang"] = _lang;
    map["status"] = _status;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}
class Vendor {
  int _id;
  String _vendorName;
  String _email;
  String _type;
  String _serial;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
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
  dynamic _companyName;
  Images _images;
  dynamic _commercialDocs;
  dynamic _taxCardDocs;
  dynamic _wholesaleDocs;

  int get id => _id;
  String get vendorName => _vendorName;
  String get email => _email;
  String get type => _type;
  String get serial => _serial;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
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
  dynamic get companyName => _companyName;
  Images get images => _images;
  dynamic get commercialDocs => _commercialDocs;
  dynamic get taxCardDocs => _taxCardDocs;
  dynamic get wholesaleDocs => _wholesaleDocs;

  Vendor({
      int id, 
      String vendorName, 
      String email, 
      String type, 
      String serial, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt, 
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
      dynamic companyName, 
      Images images, 
      dynamic commercialDocs, 
      dynamic taxCardDocs, 
      dynamic wholesaleDocs}){
    _id = id;
    _vendorName = vendorName;
    _email = email;
    _type = type;
    _serial = serial;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _useridId = useridId;
    _lang = lang;
    _commercialNo = commercialNo;
    _commercialDoc = commercialDoc;
    _taxCardNo = taxCardNo;
    _taxCardDoc = taxCardDoc;
    _bankAccount = bankAccount;
    _approved = approved;
    _complete = complete;
    _declined = declined;
    _rejected = rejected;
    _companyName = companyName;
    _images = images;
    _commercialDocs = commercialDocs;
    _taxCardDocs = taxCardDocs;
    _wholesaleDocs = wholesaleDocs;
}

  Vendor.fromJson(dynamic json) {
    _id = json["id"];
    _vendorName = json["vendor_name"];
    _email = json["email"];
    _type = json["type"];
    _serial = json["serial"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
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
    _commercialDocs = json["commercialDocs"];
    _taxCardDocs = json["taxCardDocs"];
    _wholesaleDocs = json["wholesaleDocs"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["vendor_name"] = _vendorName;
    map["email"] = _email;
    map["type"] = _type;
    map["serial"] = _serial;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    map["userid_id"] = _useridId;
    map["lang"] = _lang;
    map["commercial_no"] = _commercialNo;
    map["commercial_doc"] = _commercialDoc;
    map["tax_card_no"] = _taxCardNo;
    map["tax_card_doc"] = _taxCardDoc;
    map["bank_account"] = _bankAccount;
    map["approved"] = _approved;
    map["complete"] = _complete;
    map["declined"] = _declined;
    map["rejected"] = _rejected;
    map["company_name"] = _companyName;
    if (_images != null) {
      map["images"] = _images.toJson();
    }
    map["commercialDocs"] = _commercialDocs;
    map["taxCardDocs"] = _taxCardDocs;
    map["wholesaleDocs"] = _wholesaleDocs;

    return map;
  }

}
class Generated_conversions {
  bool _thumb;
  bool _preview;

  bool get thumb => _thumb;
  bool get preview => _preview;

  Generated_conversions({
      bool thumb, 
      bool preview}){
    _thumb = thumb;
    _preview = preview;
}

  Generated_conversions.fromJson(dynamic json) {
    _thumb = json["thumb"];
    _preview = json["preview"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["thumb"] = _thumb;
    map["preview"] = _preview;
    return map;
  }

}
class Images {
  int _id;
  String _modelType;
  int _modelId;
  String _uuid;
  String _collectionName;
  String _name;
  String _fileName;
  String _mimeType;
  String _disk;
  String _conversionsDisk;
  int _size;
  List<dynamic> _manipulations;
  int _orderColumn;
  String _createdAt;
  String _updatedAt;
  String _image;
  String _url;
  String _fullurl;
  String _thumbnail;
  String _preview;

  int get id => _id;
  String get modelType => _modelType;
  int get modelId => _modelId;
  String get uuid => _uuid;
  String get collectionName => _collectionName;
  String get name => _name;
  String get fileName => _fileName;
  String get mimeType => _mimeType;
  String get disk => _disk;
  String get conversionsDisk => _conversionsDisk;
  int get size => _size;
  List<dynamic> get manipulations => _manipulations;
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
      String modelType, 
      int modelId, 
      String uuid, 
      String collectionName, 
      String name, 
      String fileName, 
      String mimeType, 
      String disk, 
      String conversionsDisk, 
      int size, 
      List<dynamic> manipulations, 
      List<dynamic> responsiveImages,
      int orderColumn, 
      String createdAt, 
      String updatedAt, 
      String image, 
      String url, 
      String fullurl, 
      String thumbnail, 
      String preview}){
    _id = id;
    _modelType = modelType;
    _modelId = modelId;
    _uuid = uuid;
    _collectionName = collectionName;
    _name = name;
    _fileName = fileName;
    _mimeType = mimeType;
    _disk = disk;
    _conversionsDisk = conversionsDisk;
    _size = size;
    _manipulations = manipulations;
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
    _modelType = json["model_type"];
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
    map["model_type"] = _modelType;
    map["model_id"] = _modelId;
    map["uuid"] = _uuid;
    map["collection_name"] = _collectionName;
    map["name"] = _name;
    map["file_name"] = _fileName;
    map["mime_type"] = _mimeType;
    map["disk"] = _disk;
    map["conversions_disk"] = _conversionsDisk;
    map["size"] = _size;
    if (_manipulations != null) {
      map["manipulations"] = _manipulations.map((v) => v.toJson()).toList();
    }
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
