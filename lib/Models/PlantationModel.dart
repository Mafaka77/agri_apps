import 'dart:convert';

class PlantationModel {
  int? id;
  String? plantation_name;
  PlantationModel({
    this.id,
    this.plantation_name,
  });

  PlantationModel copyWith({
    int? id,
    String? plantation_name,
  }) {
    return PlantationModel(
      id: id ?? this.id,
      plantation_name: plantation_name ?? this.plantation_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantation_name': plantation_name,
    };
  }

  factory PlantationModel.fromMap(Map<String, dynamic> map) {
    return PlantationModel(
      id: map['id']?.toInt(),
      plantation_name: map['plantation_name'],
    );
  }
  static List<PlantationModel> fromJsonList(List list) {
    return list.map((e) => PlantationModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory PlantationModel.fromJson(String source) =>
      PlantationModel.fromMap(json.decode(source));

  @override
  String toString() => plantation_name!;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlantationModel &&
        other.id == id &&
        other.plantation_name == plantation_name;
  }

  @override
  int get hashCode => id.hashCode ^ plantation_name.hashCode;
}
