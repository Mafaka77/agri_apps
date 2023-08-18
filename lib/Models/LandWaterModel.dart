import 'dart:convert';

import 'package:agri_farmers_app/Models/LandCrops.dart';

class LandWaterModel {
  int? id;
  String? owner_id;
  String? location;
  String? total_area;
  String? crops_acres_or_hectares;
  int? farmers_id;
  late List<LandCrops>? crops;
  LandWaterModel({
    this.id,
    this.owner_id,
    this.location,
    this.total_area,
    this.crops_acres_or_hectares,
    this.farmers_id,
    this.crops,
  });

  LandWaterModel copyWith({
    int? id,
    String? owner_id,
    String? location,
    String? total_area,
    String? crops_acres_or_hectares,
    int? farmers_id,
  }) {
    return LandWaterModel(
      id: id ?? this.id,
      owner_id: owner_id ?? this.owner_id,
      location: location ?? this.location,
      total_area: total_area ?? this.total_area,
      crops_acres_or_hectares:
          crops_acres_or_hectares ?? this.crops_acres_or_hectares,
      farmers_id: farmers_id ?? this.farmers_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_id': owner_id,
      'location': location,
      'total_area': total_area,
      'crops_acres_or_hectares': crops_acres_or_hectares,
      'farmers_id': farmers_id,
    };
  }

  factory LandWaterModel.fromMap(Map<String, dynamic> map) {
    return LandWaterModel(
      id: map['id']?.toInt(),
      owner_id: map['owner_id'] ?? '',
      location: map['location'] ?? '',
      total_area: map['total_area'] ?? '',
      crops_acres_or_hectares: map['crops_acres_or_hectares'],
      farmers_id: map['farmers_id']?.toInt(),
      crops: LandCrops.fromJsonList(
        map['land_crops'] ?? [],
      ),
    );
  }
  static List<LandWaterModel> fromJsonList(List list) {
    return list.map((e) => LandWaterModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory LandWaterModel.fromJson(String source) =>
      LandWaterModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LandWaterModel(id: $id, owner_id: $owner_id, location: $location, total_area: $total_area, crops_acres_or_hectares: $crops_acres_or_hectares, farmers_id: $farmers_id)';
  }
}
