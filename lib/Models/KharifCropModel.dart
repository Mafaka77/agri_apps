class KharifCropModel {
  int id;
  String kharif_crops_name;
  KharifCropModel({
    required this.id,
    required this.kharif_crops_name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kharif_crops_name': kharif_crops_name,
    };
  }

  factory KharifCropModel.fromMap(Map<String, dynamic> map) {
    return KharifCropModel(
      id: map['id']?.toInt() ?? 0,
      kharif_crops_name: map['kharif_crops_name'] ?? '',
    );
  }

  static List<KharifCropModel> fromJsonList(List list) {
    return list.map((e) => KharifCropModel.fromMap(e)).toList();
  }

  @override
  String toString() => kharif_crops_name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KharifCropModel &&
        other.id == id &&
        other.kharif_crops_name == kharif_crops_name;
  }

  @override
  int get hashCode => id.hashCode ^ kharif_crops_name.hashCode;
}
