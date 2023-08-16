import 'dart:convert';

class VillageModel {
  int id;
  String village_name;
  String village_lgd_code;
  int block_id;
  VillageModel({
    required this.id,
    required this.village_name,
    required this.village_lgd_code,
    required this.block_id,
  });

  VillageModel copyWith({
    int? id,
    String? village_name,
    String? village_lgd_code,
    int? block_id,
  }) {
    return VillageModel(
      id: id ?? this.id,
      village_name: village_name ?? this.village_name,
      village_lgd_code: village_lgd_code ?? this.village_lgd_code,
      block_id: block_id ?? this.block_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'village_name': village_name,
      'village_lgd_code': village_lgd_code,
      'block_id': block_id,
    };
  }

  factory VillageModel.fromMap(Map<String, dynamic> map) {
    return VillageModel(
      id: map['id']?.toInt() ?? 0,
      village_name: map['village_name'] ?? '',
      village_lgd_code: map['village_lgd_code'] ?? '',
      block_id: map['block_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VillageModel.fromJson(String source) =>
      VillageModel.fromMap(json.decode(source));

  static List<VillageModel> fromJsonList(List list) {
    return list.map((e) => VillageModel.fromMap(e)).toList();
  }

  @override
  String toString() => village_name;
}
