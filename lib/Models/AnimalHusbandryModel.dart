import 'dart:convert';

import 'package:agri_farmers_app/Models/LivestockModel.dart';
import 'package:agri_farmers_app/Models/TypeOfBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfFarmModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryFarmModel.dart';

class AnimalHusbandryModel {
  int? id;
  String? husbandry_id;
  String? location;
  int? adult_male;
  int? adult_female;
  int? young_stock;
  int? total;
  int? no_of_poultry;
  int? farmers_id;
  late List<LivestockModel>? livestock;
  late List<TypeOfFarmModel>? typeOfFarm;
  late List<TypeOfBreedModel>? typeOfBreed;
  late List<TypeOfPoultryFarmModel>? typeOfPoultryFarm;
  late List<TypeOfPoultryBreedModel>? typeOfPoultryBreed;
  AnimalHusbandryModel({
    this.id,
    this.husbandry_id,
    this.location,
    this.adult_male,
    this.adult_female,
    this.young_stock,
    this.total,
    this.no_of_poultry,
    this.farmers_id,
    this.livestock,
    this.typeOfFarm,
    this.typeOfBreed,
    this.typeOfPoultryFarm,
    this.typeOfPoultryBreed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'husbandry_id': husbandry_id,
      'location': location,
      'adult_male': adult_male,
      'adult_female': adult_female,
      'young_stock': young_stock,
      'total': total,
      'no_of_poultry': no_of_poultry,
      'farmers_id': farmers_id,
    };
  }

  factory AnimalHusbandryModel.fromMap(Map<String, dynamic> map) {
    return AnimalHusbandryModel(
      id: map['id']?.toInt(),
      husbandry_id: map['husbandry_id'],
      location: map['location'],
      adult_male: map['adult_male']?.toInt(),
      adult_female: map['adult_female']?.toInt(),
      young_stock: map['young_stock']?.toInt(),
      total: map['total']?.toInt(),
      no_of_poultry: map['no_of_poultry']?.toInt(),
      farmers_id: map['farmers_id']?.toInt(),
      livestock: LivestockModel.fromJsonList(map['livestock'] ?? []),
      typeOfFarm: TypeOfFarmModel.fromJsonList(map['type_of_farm'] ?? []),
      typeOfBreed:
          TypeOfBreedModel.fromJsonList(map['husbandry_type_breed'] ?? []),
      typeOfPoultryFarm:
          TypeOfPoultryFarmModel.fromJsonList(map['poultry_farm'] ?? []),
      typeOfPoultryBreed:
          TypeOfPoultryBreedModel.fromJsonList(map['type_of_breed'] ?? []),
    );
  }

  static List<AnimalHusbandryModel> fromJsonList(List list) {
    return list.map((e) => AnimalHusbandryModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory AnimalHusbandryModel.fromJson(String source) =>
      AnimalHusbandryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnimalHusbandryModel(id: $id, husbandry_id: $husbandry_id, location: $location, adult_male: $adult_male, adult_female: $adult_female, young_stock: $young_stock, total: $total, no_of_poultry: $no_of_poultry, farmers_id: $farmers_id)';
  }
}
