import 'dart:convert';

class RdBlockModel {
  int id;
  String block_name;
  int district_id;
  RdBlockModel({
    required this.id,
    required this.block_name,
    required this.district_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'block_name': block_name,
      'district_id': district_id,
    };
  }

  factory RdBlockModel.fromMap(Map<String, dynamic> map) {
    return RdBlockModel(
      id: map['id'],
      block_name: map['block_name'],
      district_id: map['district_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RdBlockModel.fromJson(String source) =>
      RdBlockModel.fromMap(json.decode(source));

  static List<RdBlockModel> fromJsonList(List list) {
    return list.map((e) => RdBlockModel.fromMap(e)).toList();
  }

  @override
  String toString() => block_name;
}
