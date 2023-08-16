import 'dart:convert';

class FarmEquipmentModel {
  int id;
  String equipment_name;
  FarmEquipmentModel({
    required this.id,
    required this.equipment_name,
  });

  FarmEquipmentModel copyWith({
    int? id,
    String? equipment_name,
  }) {
    return FarmEquipmentModel(
      id: id ?? this.id,
      equipment_name: equipment_name ?? this.equipment_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'equipment_name': equipment_name,
    };
  }

  factory FarmEquipmentModel.fromMap(Map<String, dynamic> map) {
    return FarmEquipmentModel(
      id: map['id']?.toInt() ?? 0,
      equipment_name: map['equipment_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmEquipmentModel.fromJson(String source) =>
      FarmEquipmentModel.fromMap(json.decode(source));
  static List<FarmEquipmentModel> fromJsonList(List list) {
    return list.map((e) => FarmEquipmentModel.fromMap(e)).toList();
  }

  @override
  String toString() => equipment_name;
}
