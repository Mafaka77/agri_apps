import 'dart:convert';

class TypeOfBreedModel {
  int? id;
  String? name;
  TypeOfBreedModel({
    this.id,
    this.name,
  });

  TypeOfBreedModel copyWith({
    int? id,
    String? name,
  }) {
    return TypeOfBreedModel(
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

  factory TypeOfBreedModel.fromMap(Map<String, dynamic> map) {
    return TypeOfBreedModel(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }
  static List<TypeOfBreedModel> fromJsonList(List list) {
    return list.map((e) => TypeOfBreedModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory TypeOfBreedModel.fromJson(String source) =>
      TypeOfBreedModel.fromMap(json.decode(source));

  @override
  String toString() => name!;
}
