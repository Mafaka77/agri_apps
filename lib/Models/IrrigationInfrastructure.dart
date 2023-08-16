import 'dart:convert';

class IrrigationInfrastructureModel {
  int id;
  String irrigation_infrastructures_name;
  IrrigationInfrastructureModel({
    required this.id,
    required this.irrigation_infrastructures_name,
  });

  IrrigationInfrastructureModel copyWith({
    int? id,
    String? irrigation_infrastructures_name,
  }) {
    return IrrigationInfrastructureModel(
      id: id ?? this.id,
      irrigation_infrastructures_name: irrigation_infrastructures_name ??
          this.irrigation_infrastructures_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'irrigation_infrastructures_name': irrigation_infrastructures_name,
    };
  }

  factory IrrigationInfrastructureModel.fromMap(Map<String, dynamic> map) {
    return IrrigationInfrastructureModel(
      id: map['id']?.toInt() ?? 0,
      irrigation_infrastructures_name:
          map['irrigation_infrastructures_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  static List<IrrigationInfrastructureModel> fromJsonList(List list) {
    return list.map((e) => IrrigationInfrastructureModel.fromMap(e)).toList();
  }

  @override
  String toString() => irrigation_infrastructures_name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IrrigationInfrastructureModel &&
        other.id == id &&
        other.irrigation_infrastructures_name ==
            irrigation_infrastructures_name;
  }

  @override
  int get hashCode => id.hashCode ^ irrigation_infrastructures_name.hashCode;
}
