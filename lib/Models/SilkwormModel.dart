class SilkwormModel {
  int? id;
  String? silkworm_name;
  SilkwormModel({
    this.id,
    this.silkworm_name,
  });

  SilkwormModel copyWith({
    int? id,
    String? silkworm_name,
  }) {
    return SilkwormModel(
      id: id ?? this.id,
      silkworm_name: silkworm_name ?? this.silkworm_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'silkworm_name': silkworm_name,
    };
  }

  factory SilkwormModel.fromMap(Map<String, dynamic> map) {
    return SilkwormModel(
      id: map['id']?.toInt(),
      silkworm_name: map['silkworm_name'],
    );
  }
  static List<SilkwormModel> fromJsonList(List list) {
    return list.map((e) => SilkwormModel.fromMap(e)).toList();
  }

  @override
  String toString() => silkworm_name!;
}
