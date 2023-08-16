import 'dart:convert';

class SubDivisionModel {
  int id;
  String sub_division_name;
  SubDivisionModel({
    required this.id,
    required this.sub_division_name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sub_division_name': sub_division_name,
    };
  }

  factory SubDivisionModel.fromMap(Map<String, dynamic> map) {
    return SubDivisionModel(
      id: map['id'],
      sub_division_name: map['sub_division_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubDivisionModel.fromJson(String source) =>
      SubDivisionModel.fromMap(json.decode(source));
  static List<SubDivisionModel> fromJsonList(List list) {
    return list.map((e) => SubDivisionModel.fromMap(e)).toList();
  }

  @override
  String toString() => sub_division_name;
}
