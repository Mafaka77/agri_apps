import 'dart:convert';

class GreenHouseModel {
  int? id;
  String? name;
  GreenHouseModel({
    this.id,
    this.name,
  });

  GreenHouseModel copyWith({
    int? id,
    String? name,
  }) {
    return GreenHouseModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory GreenHouseModel.fromMap(Map<String, dynamic> map) {
    return GreenHouseModel(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }
  static List<GreenHouseModel> fromJsonList(List list) {
    return list.map((e) => GreenHouseModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory GreenHouseModel.fromJson(String source) =>
      GreenHouseModel.fromMap(json.decode(source));

  @override
  String toString() => name!;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GreenHouseModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
