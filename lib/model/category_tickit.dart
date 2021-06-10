/// data : [{"id":1,"name":"technical"}]

class Category_tickit {
  List<Categorytickit> _data;

  List<Categorytickit> get data => _data;

  Category_tickit({
      List<Categorytickit> data}){
    _data = data;
}

  Category_tickit.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Categorytickit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "technical"

class Categorytickit {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Categorytickit({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Categorytickit.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}