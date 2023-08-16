class RabiCropModel {
  int id;
  String rabi_crops_name;
  RabiCropModel({
    required this.id,
    required this.rabi_crops_name,
  });

  RabiCropModel copyWith({
    int? id,
    String? rabi_crops_name,
  }) {
    return RabiCropModel(
      id: id ?? this.id,
      rabi_crops_name: rabi_crops_name ?? this.rabi_crops_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rabi_crops_name': rabi_crops_name,
    };
  }

  factory RabiCropModel.fromMap(Map<String, dynamic> map) {
    return RabiCropModel(
      id: map['id']?.toInt() ?? 0,
      rabi_crops_name: map['rabi_crops_name'] ?? '',
    );
  }

  static List<RabiCropModel> fromJsonList(List list) {
    return list.map((e) => RabiCropModel.fromMap(e)).toList();
  }

  @override
  String toString() => rabi_crops_name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RabiCropModel &&
        other.id == id &&
        other.rabi_crops_name == rabi_crops_name;
  }

  @override
  int get hashCode => id.hashCode ^ rabi_crops_name.hashCode;
}
