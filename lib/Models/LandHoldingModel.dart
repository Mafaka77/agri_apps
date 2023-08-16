import 'dart:convert';

class LandHoldingModel {
  int id;
  String land_holding_name;
  LandHoldingModel({
    required this.id,
    required this.land_holding_name,
  });

  LandHoldingModel copyWith({
    int? id,
    String? land_holding_name,
  }) {
    return LandHoldingModel(
      id: id ?? this.id,
      land_holding_name: land_holding_name ?? this.land_holding_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'land_holding_name': land_holding_name,
    };
  }

  factory LandHoldingModel.fromMap(Map<String, dynamic> map) {
    return LandHoldingModel(
      id: map['id']?.toInt() ?? 0,
      land_holding_name: map['land_holding_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LandHoldingModel.fromJson(String source) =>
      LandHoldingModel.fromMap(json.decode(source));

  static List<LandHoldingModel> fromJsonList(List list) {
    return list.map((e) => LandHoldingModel.fromMap(e)).toList();
  }

  @override
  String toString() => land_holding_name;
}
