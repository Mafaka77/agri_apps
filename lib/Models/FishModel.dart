import 'dart:convert';

class FishModel {
  int? id;
  String? fish_name;
  FishModel({
    this.id,
    this.fish_name,
  });

  FishModel copyWith({
    int? id,
    String? fish_name,
  }) {
    return FishModel(
      id: id ?? this.id,
      fish_name: fish_name ?? this.fish_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fish_name': fish_name,
    };
  }

  factory FishModel.fromMap(Map<String, dynamic> map) {
    return FishModel(
      id: map['id']?.toInt(),
      fish_name: map['fish_name'],
    );
  }
  static List<FishModel> fromJsonList(List list) {
    return list.map((e) => FishModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory FishModel.fromJson(String source) =>
      FishModel.fromMap(json.decode(source));

  @override
  String toString() => fish_name!;
}
