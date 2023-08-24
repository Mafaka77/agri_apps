import 'dart:convert';

class TypeOfPoultryBreedModel {
  int? id;
  String? name;
  TypeOfPoultryBreedModel({
    this.id,
    this.name,
  });

  TypeOfPoultryBreedModel copyWith({
    int? id,
    String? name,
  }) {
    return TypeOfPoultryBreedModel(
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

  factory TypeOfPoultryBreedModel.fromMap(Map<String, dynamic> map) {
    return TypeOfPoultryBreedModel(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }
  static List<TypeOfPoultryBreedModel> fromJsonList(List list) {
    return list.map((e) => TypeOfPoultryBreedModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory TypeOfPoultryBreedModel.fromJson(String source) =>
      TypeOfPoultryBreedModel.fromMap(json.decode(source));

  @override
  String toString() => name!;
}
