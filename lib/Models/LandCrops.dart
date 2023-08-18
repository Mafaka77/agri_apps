import 'dart:convert';

class LandCrops {
  int? id;
  String? crop_name;
  LandCrops({
    this.id,
    this.crop_name,
  });

  LandCrops copyWith({
    int? id,
    String? crop_name,
  }) {
    return LandCrops(
      id: id ?? this.id,
      crop_name: crop_name ?? this.crop_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'crop_name': crop_name,
    };
  }

  factory LandCrops.fromMap(Map<String, dynamic> map) {
    return LandCrops(
      id: map['id']?.toInt(),
      crop_name: map['crop_name'],
    );
  }
  static List<LandCrops> fromJsonList(List list) {
    return list.map((e) => LandCrops.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory LandCrops.fromJson(String source) =>
      LandCrops.fromMap(json.decode(source));

  @override
  String toString() => crop_name!;
}
