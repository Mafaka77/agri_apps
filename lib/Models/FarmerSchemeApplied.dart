import 'dart:convert';

import 'SchemeModel.dart';

class FarmerSchemeApplied {
  int? id;
  int? schemes_id;
  int? additional_farmer_details_id;
  int? availed;
  String? amount;
  late SchemeModel? schemeModel;
  FarmerSchemeApplied({
    this.id,
    this.schemes_id,
    this.additional_farmer_details_id,
    this.availed,
    this.amount,
    this.schemeModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'schemes_id': schemes_id,
      'additional_farmer_details_id': additional_farmer_details_id,
      'availed': availed,
      'amount': amount,
    };
  }

  factory FarmerSchemeApplied.fromMap(Map<String, dynamic> map) {
    return FarmerSchemeApplied(
      id: map['id']?.toInt(),
      schemes_id: map['schemes_id']?.toInt(),
      additional_farmer_details_id:
          map['additional_farmer_details_id']?.toInt(),
      availed: map['availed']?.toInt(),
      amount: map['amount'] ?? '',
      schemeModel: SchemeModel.fromMap(map['schemes']),
    );
  }
  static List<FarmerSchemeApplied> fromJsonList(List list) {
    return list.map((e) => FarmerSchemeApplied.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory FarmerSchemeApplied.fromJson(String source) =>
      FarmerSchemeApplied.fromMap(json.decode(source));
}
