import 'dart:convert';

import 'package:agri_farmers_app/Models/GreenHouseModel.dart';
import 'package:agri_farmers_app/Models/KharifCropModel.dart';
import 'package:agri_farmers_app/Models/OrchardModel.dart';
import 'package:agri_farmers_app/Models/PlantationModel.dart';
import 'package:agri_farmers_app/Models/RabiCropModel.dart';

class HorticultureModel {
  int? id;
  int? farmers_id;
  String? farmer_horticulture_id;
  String? location;
  String? kharif_acres_or_hectares;
  String? kharif_total_area;
  String? rabi_acres_or_hectares;
  String? rabi_total_area;
  String? total_greenhouse_area;
  late List<KharifCropModel>? kharifCrop;
  late List<RabiCropModel>? rabiCrops;
  late List<OrchardModel>? orchards;
  late List<PlantationModel>? plantation;
  late List<GreenHouseModel>? grenhouse;
  HorticultureModel({
    this.id,
    this.farmers_id,
    this.farmer_horticulture_id,
    this.location,
    this.kharif_acres_or_hectares,
    this.kharif_total_area,
    this.rabi_acres_or_hectares,
    this.rabi_total_area,
    this.total_greenhouse_area,
    this.kharifCrop,
    this.rabiCrops,
    this.orchards,
    this.plantation,
    this.grenhouse,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'farmers_id': farmers_id,
      'farmer_horticulture_id': farmer_horticulture_id,
      'location': location,
      'kharif_acres_or_hectares': kharif_acres_or_hectares,
      'kharif_total_area': kharif_total_area,
      'rabi_acres_or_hectares': rabi_acres_or_hectares,
      'rabi_total_area': rabi_total_area,
      'total_greenhouse_area': total_greenhouse_area,
    };
  }

  factory HorticultureModel.fromMap(Map<String, dynamic> map) {
    return HorticultureModel(
      id: map['id']?.toInt(),
      farmers_id: map['farmers_id']?.toInt(),
      farmer_horticulture_id: map['farmer_horticulture_id'] ?? '',
      location: map['location'],
      kharif_acres_or_hectares: map['kharif_acres_or_hectares'],
      kharif_total_area: map['kharif_total_area'] ?? '',
      rabi_acres_or_hectares: map['rabi_acres_or_hectares'],
      rabi_total_area: map['rabi_total_area'] ?? '',
      total_greenhouse_area: map['total_greenhouse_area'] ?? '',
      kharifCrop:
          KharifCropModel.fromJsonList(map['farmer_horti_kharif_crops'] ?? []),
      rabiCrops:
          RabiCropModel.fromJsonList(map['farmer_horti_rabi_crops'] ?? []),
      orchards: OrchardModel.fromJsonList(map['farmer_orchids'] ?? []),
      plantation: PlantationModel.fromJsonList(map['farmer_plantation'] ?? []),
      grenhouse: GreenHouseModel.fromJsonList(map['green_house_plants'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory HorticultureModel.fromJson(String source) =>
      HorticultureModel.fromMap(json.decode(source));
  static List<HorticultureModel> fromJsonList(List list) {
    return list.map((e) => HorticultureModel.fromMap(e)).toList();
  }

  @override
  String toString() {
    return 'HorticultureModel(id: $id, farmers_id: $farmers_id, farmer_horticulture_id: $farmer_horticulture_id, location: $location, kharif_acres_or_hectares: $kharif_acres_or_hectares, kharif_total_area: $kharif_total_area, rabi_acres_or_hectares: $rabi_acres_or_hectares, rabi_total_area: $rabi_total_area)';
  }
}
