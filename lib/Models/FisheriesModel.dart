import 'dart:convert';

import 'package:agri_farmers_app/Models/FishModel.dart';

class FisheriesModel {
  int? id;
  String? fisheries_id;
  String? location;
  String? acres_or_hectares;
  String? total_area;
  int? total_ponds;
  int? nursery_ponds;
  int? rearing_ponds;
  int? grew_out_ponds;
  String? fish_hatchery;
  int? farmers_id;
  late List<FishModel>? fish;
  FisheriesModel({
    this.id,
    this.fisheries_id,
    this.location,
    this.acres_or_hectares,
    this.total_area,
    this.total_ponds,
    this.nursery_ponds,
    this.rearing_ponds,
    this.grew_out_ponds,
    this.fish_hatchery,
    this.farmers_id,
    this.fish,
  });

  FisheriesModel copyWith({
    int? id,
    String? fisheries_id,
    String? location,
    String? acres_or_hectares,
    String? total_area,
    int? total_ponds,
    int? nursery_ponds,
    int? rearing_ponds,
    int? grew_out_ponds,
    String? fish_hatchery,
    int? farmers_id,
  }) {
    return FisheriesModel(
      id: id ?? this.id,
      fisheries_id: fisheries_id ?? this.fisheries_id,
      location: location ?? this.location,
      acres_or_hectares: acres_or_hectares ?? this.acres_or_hectares,
      total_area: total_area ?? this.total_area,
      total_ponds: total_ponds ?? this.total_ponds,
      nursery_ponds: nursery_ponds ?? this.nursery_ponds,
      rearing_ponds: rearing_ponds ?? this.rearing_ponds,
      grew_out_ponds: grew_out_ponds ?? this.grew_out_ponds,
      fish_hatchery: fish_hatchery ?? this.fish_hatchery,
      farmers_id: farmers_id ?? this.farmers_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fisheries_id': fisheries_id,
      'location': location,
      'acres_or_hectares': acres_or_hectares,
      'total_area': total_area,
      'total_ponds': total_ponds,
      'nursery_ponds': nursery_ponds,
      'rearing_ponds': rearing_ponds,
      'grew_out_ponds': grew_out_ponds,
      'fish_hatchery': fish_hatchery,
      'farmers_id': farmers_id,
    };
  }

  factory FisheriesModel.fromMap(Map<String, dynamic> map) {
    return FisheriesModel(
        id: map['id']?.toInt(),
        fisheries_id: map['fisheries_id'],
        location: map['location'],
        acres_or_hectares: map['acres_or_hectares'],
        total_area: map['total_area'],
        total_ponds: map['total_ponds']?.toInt(),
        nursery_ponds: map['nursery_ponds']?.toInt(),
        rearing_ponds: map['rearing_ponds']?.toInt(),
        grew_out_ponds: map['grew_out_ponds']?.toInt(),
        fish_hatchery: map['fish_hatchery'],
        farmers_id: map['farmers_id']?.toInt(),
        fish: FishModel.fromJsonList(map['fish'] ?? []));
  }
  static List<FisheriesModel> fromJsonList(List list) {
    return list.map((e) => FisheriesModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());
  factory FisheriesModel.fromJson(String source) =>
      FisheriesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FisheriesModel(id: $id, fisheries_id: $fisheries_id, location: $location, acres_or_hectares: $acres_or_hectares, total_area: $total_area, total_ponds: $total_ponds, nursery_ponds: $nursery_ponds, rearing_ponds: $rearing_ponds, grew_out_ponds: $grew_out_ponds, fish_hatchery: $fish_hatchery, farmers_id: $farmers_id)';
  }
}
