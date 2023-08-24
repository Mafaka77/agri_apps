import 'dart:convert';

class TypeOfFarmModel {
  int? id;
  String? name;
  TypeOfFarmModel({
    this.id,
    this.name,
  });

  TypeOfFarmModel copyWith({
    int? id,
    String? name,
  }) {
    return TypeOfFarmModel(
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

  factory TypeOfFarmModel.fromMap(Map<String, dynamic> map) {
    return TypeOfFarmModel(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }
  static List<TypeOfFarmModel> fromJsonList(List list) {
    return list.map((e) => TypeOfFarmModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory TypeOfFarmModel.fromJson(String source) =>
      TypeOfFarmModel.fromMap(json.decode(source));

  @override
  String toString() => name!;
}
