class PartCategory {
  int statusCode;
  String message;
  List<Category> data;
  PartCategory({this.statusCode, this.message, this.data});
  PartCategory.fromJson(Map<String, dynamic> json) {
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
  List<PartCategories> partCategories;

  Category(
      {this.id, this.name, this.description, this.lang, this.partCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    lang = json['lang'];
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
    if (this.partCategories != null) {
      data['part_categories'] =
          this.partCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartCategories {
  int id;
  String categoryName;
  String lang;
  int categoryId;

  PartCategories({this.id, this.categoryName, this.lang, this.categoryId});

  PartCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    lang = json['lang'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['lang'] = this.lang;
    data['category_id'] = this.categoryId;
    return data;
  }
}
