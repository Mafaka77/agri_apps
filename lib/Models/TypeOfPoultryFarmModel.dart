import 'dart:convert';

class TypeOfPoultryFarmModel {
  int? id;
  String? name;
  TypeOfPoultryFarmModel({
    this.id,
    this.name,
  });

  TypeOfPoultryFarmModel copyWith({
    int? id,
    String? name,
  }) {
    return TypeOfPoultryFarmModel(
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

  factory TypeOfPoultryFarmModel.fromMap(Map<String, dynamic> map) {
    return TypeOfPoultryFarmModel(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }
  static List<TypeOfPoultryFarmModel> fromJsonList(List list) {
    return list.map((e) => TypeOfPoultryFarmModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory TypeOfPoultryFarmModel.fromJson(String source) =>
      TypeOfPoultryFarmModel.fromMap(json.decode(source));

  @override
  String toString() => name!;
}
