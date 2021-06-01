class Category_model {
  int statusCode;
  String message;
  List<Category> data;

  Category_model({this.statusCode, this.message, this.data});

  Category_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Category>();
      json['data'].forEach((v) {
        data.add(new Category.fromJson(v));
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

class Category {
  int id;
  String name;
  String description;
  String lang;
  Photo photo;
  List<PartCategories>partCategories;

  Category(
      {this.id,
        this.name,
        this.description,
        this.lang,
        this.photo,
        this.partCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['category_name']??json['name'];
    description = json['description'];
    lang = json['lang'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    if (json['part_categories'] != null) {
      partCategories = new List<PartCategories>();
      json['part_categories'].forEach((v) {
        partCategories.add(new PartCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['lang'] = this.lang;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    if (this.partCategories != null) {
      data['part_categories'] =
          this.partCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photo {
  int id;
  String image;

  Photo({this.id, this.image});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

class PartCategories {
  int id;
  String categoryName;
  String lang;
  int categoryId;
  Photo photo;

  PartCategories(
      {this.id,
        this.categoryName,
        this.lang,
        this.categoryId,
        this.photo});

  PartCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    lang = json['lang'];
    categoryId = json['category_id'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['lang'] = this.lang;
    data['category_id'] = this.categoryId;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    return data;
  }
}

