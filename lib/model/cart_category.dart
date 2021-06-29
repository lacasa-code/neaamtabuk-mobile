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
  String mainCategoryName;
  List<Categories> categories;

  Category({this.id, this.mainCategoryName, this.categories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryName = json['main_category_name'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main_category_name'] = this.mainCategoryName;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int id;
  String name;
  String description;
  int lastLevel;
  bool partsCheck=false;
  List<PartCategories> partCategories;

  Categories(
      {this.id,
        this.name,
        this.description,
        this.lastLevel,
        this.partCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    lastLevel = json['last_level'];
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
    data['last_level'] = this.lastLevel;
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

  PartCategories({this.id, this.categoryName, this.lang});

  PartCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['lang'] = this.lang;
    return data;
  }
}
