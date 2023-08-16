import 'dart:convert';

import 'package:agri_farmers_app/Models/DistrictModel.dart';
import 'package:agri_farmers_app/Models/FarmEquipmentModel.dart';
import 'package:agri_farmers_app/Models/IrrigationInfrastructure.dart';
import 'package:agri_farmers_app/Models/KharifCropModel.dart';
import 'package:agri_farmers_app/Models/LandHoldingModel.dart';
import 'package:agri_farmers_app/Models/OwnershipTypeModel.dart';
import 'package:agri_farmers_app/Models/RabiCropModel.dart';
import 'package:agri_farmers_app/Models/RdBlockModel.dart';
import 'package:agri_farmers_app/Models/SubDivisionModel.dart';
import 'package:agri_farmers_app/Models/VillageModel.dart';

class AgricultureLandModel {
  int? id;
  int? ids;
  int? farmers_id;
  String? farmer_agri_id;
  String? land_owner_name;
  String? area_of_land;
  String? acres_or_hectares;
  String? latitude;
  String? longitude;
  String? altitude;
  String? landholding_documents_number;
  String? land_holding_file;
  String? other_irrigation_infrastructure;
  String? other_farm_equipment;
  String? kharif_acres_or_hectares;
  String? kharif_total_area;
  String? rabi_acres_or_hectares;
  String? rabi_total_area;
  int? district_id;
  int? sub_division_id;
  int? block_id;
  int? village_id;
  int? land_holding_id;
  int? ownership_type_id;
  String? oil_palm_plantation;
  String? oil_palm_area;
  late LandHoldingModel? landHolding;
  late DistrictModel? district;
  late SubDivisionModel? subDivision;
  late RdBlockModel? block;
  late VillageModel? village;
  late OwnershipTypeModel? ownershipType;
  late List<IrrigationInfrastructureModel>? infrastructure;
  late List<FarmEquipmentModel>? equipment;
  late List<KharifCropModel>? kharifCrop;
  late List<RabiCropModel>? rabiCrop;
  AgricultureLandModel({
    this.id,
    this.ids,
    this.farmers_id,
    this.farmer_agri_id,
    this.land_owner_name,
    this.area_of_land,
    this.acres_or_hectares,
    this.latitude,
    this.longitude,
    this.altitude,
    this.landholding_documents_number,
    this.land_holding_file,
    this.other_irrigation_infrastructure,
    this.other_farm_equipment,
    this.kharif_acres_or_hectares,
    this.kharif_total_area,
    this.rabi_acres_or_hectares,
    this.rabi_total_area,
    this.district_id,
    this.sub_division_id,
    this.block_id,
    this.village_id,
    this.land_holding_id,
    this.ownership_type_id,
    this.landHolding,
    this.district,
    this.subDivision,
    this.block,
    this.village,
    this.ownershipType,
    this.infrastructure,
    this.equipment,
    this.kharifCrop,
    this.rabiCrop,
    this.oil_palm_plantation,
    this.oil_palm_area,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ids': ids,
      'farmers_id': farmers_id,
      'farmer_agri_id': farmer_agri_id,
      'land_owner_name': land_owner_name,
      'area_of_land': area_of_land,
      'acres_or_hectares': acres_or_hectares,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'landholding_documents_number': landholding_documents_number,
      'land_holding_file': land_holding_file,
      'other_irrigation_infrastructure': other_irrigation_infrastructure,
      'other_farm_equipment': other_farm_equipment,
      'kharif_acres_or_hectares': kharif_acres_or_hectares,
      'kharif_total_area': kharif_total_area,
      'rabi_acres_or_hectares': rabi_acres_or_hectares,
      'rabi_total_area': rabi_total_area,
      'district_id': district_id,
      'sub_division_id': sub_division_id,
      'block_id': block_id,
      'village_id': village_id,
      'land_holding_id': land_holding_id,
      'ownership_type_id': ownership_type_id,
      'oil_palm_plantation': oil_palm_plantation == 'Yes' ? 1 : 0,
      'oil_palm_area': oil_palm_area
    };
  }

  factory AgricultureLandModel.fromMap(Map<String, dynamic> map) {
    return AgricultureLandModel(
      id: map['id']?.toInt(),
      ids: map['ids']?.toInt(),
      farmers_id: map['farmers_id']?.toInt(),
      farmer_agri_id: map['farmer_agri_id'] ?? '',
      land_owner_name: map['land_owner_name'],
      area_of_land: map['area_of_land'],
      acres_or_hectares: map['acres_or_hectares'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      altitude: map['altitude'],
      landholding_documents_number: map['landholding_documents_number'],
      land_holding_file: map['land_holding_file'],
      other_irrigation_infrastructure: map['other_irrigation_infrastructure'],
      other_farm_equipment: map['other_farm_equipment'],
      kharif_acres_or_hectares: map['kharif_acres_or_hectares'],
      kharif_total_area: map['kharif_total_area'] ?? '',
      rabi_acres_or_hectares: map['rabi_acres_or_hectares'],
      rabi_total_area: map['rabi_total_area'] ?? '',
      district_id: map['district_id']?.toInt(),
      sub_division_id: map['sub_division_id']?.toInt(),
      block_id: map['block_id']?.toInt(),
      village_id: map['village_id']?.toInt(),
      land_holding_id: map['land_holding_id']?.toInt(),
      ownership_type_id: map['ownership_type_id']?.toInt(),
      oil_palm_plantation: map['oil_palm_plantation'] == 1 ? 'Yes' : 'No',
      oil_palm_area: map['oil_palm_area'] ?? '',
      landHolding: LandHoldingModel.fromMap(map['land_holding']),
      district: DistrictModel.fromMap(map['district'] ?? []),
      subDivision: SubDivisionModel.fromMap(map['sub_division']),
      block: RdBlockModel.fromMap(map['block']),
      village: VillageModel.fromMap(map['village']),
      ownershipType: OwnershipTypeModel.fromMap(map['ownership_type']),
      infrastructure: IrrigationInfrastructureModel.fromJsonList(
          map['irrigation_infrastructures'] ?? []),
      equipment: FarmEquipmentModel.fromJsonList(map['farm_equipments'] ?? []),
      kharifCrop: KharifCropModel.fromJsonList(map['kharif_crops'] ?? []),
      rabiCrop: RabiCropModel.fromJsonList(map['rabi_crops'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgricultureLandModel.fromJson(String source) =>
      AgricultureLandModel.fromMap(json.decode(source));

  static List<AgricultureLandModel> fromJsonList(List list) {
    return list.map((e) => AgricultureLandModel.fromMap(e)).toList();
  }

  @override
  String toString() {
    return 'AgricultureLandModel(id: $id, ids: $ids, farmers_id: $farmers_id, farmer_agri_id: $farmer_agri_id, land_owner_name: $land_owner_name, area_of_land: $area_of_land, acres_or_hectares: $acres_or_hectares, latitude: $latitude, longitude: $longitude, altitude: $altitude, landholding_documents_number: $landholding_documents_number, land_holding_file: $land_holding_file, other_irrigation_infrastructure: $other_irrigation_infrastructure, other_farm_equipment: $other_farm_equipment, kharif_acres_or_hectares: $kharif_acres_or_hectares, kharif_total_area: $kharif_total_area, rabi_acres_or_hectares: $rabi_acres_or_hectares, rabi_total_area: $rabi_total_area, district_id: $district_id, sub_division_id: $sub_division_id, block_id: $block_id, village_id: $village_id, land_holding_id: $land_holding_id, ownership_type_id: $ownership_type_id)';
  }
}
