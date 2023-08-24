import 'dart:convert';

import 'package:agri_farmers_app/Models/SilkwormModel.dart';

class SericultureModel {
  int? id;
  String? sericulture_id;
  String? location;
  String? total_area;
  String? size_of_rearing_unit;
  String? plantation_total_area;
  int? farmers_id;
  late List<SilkwormModel>? silkworm;
  SericultureModel({
    this.id,
    this.sericulture_id,
    this.location,
    this.total_area,
    this.size_of_rearing_unit,
    this.plantation_total_area,
    this.farmers_id,
    this.silkworm,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sericulture_id': sericulture_id,
      'location': location,
      'total_area': total_area,
      'size_of_rearing_unit': size_of_rearing_unit,
      'plantation_total_area': plantation_total_area,
      'farmers_id': farmers_id,
    };
  }

  factory SericultureModel.fromMap(Map<String, dynamic> map) {
    return SericultureModel(
        id: map['id']?.toInt(),
        sericulture_id: map['sericulture_id'] ?? '',
        location: map['location'] ?? '',
        total_area: map['total_area'] ?? '',
        size_of_rearing_unit: map['size_of_rearing_unit'] ?? '',
        plantation_total_area: map['plantation_total_area'] ?? '',
        farmers_id: map['farmers_id']?.toInt(),
        silkworm: SilkwormModel.fromJsonList(map['silkworm'] ?? []));
  }
  static List<SericultureModel> fromJsonList(List list) {
    return list.map((e) => SericultureModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory SericultureModel.fromJson(String source) =>
      SericultureModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SericultureModel(id: $id, sericulture_id: $sericulture_id, location: $location, total_area: $total_area, size_of_rearing_unit: $size_of_rearing_unit, plantation_total_area: $plantation_total_area, farmers_id: $farmers_id)';
  }
}
