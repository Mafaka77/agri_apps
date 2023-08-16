import 'dart:convert';

class SchemeModel {
  int id;
  String scheme_name;
  SchemeModel({
    required this.id,
    required this.scheme_name,
  });

  SchemeModel copyWith({
    int? id,
    String? scheme_name,
  }) {
    return SchemeModel(
      id: id ?? this.id,
      scheme_name: scheme_name ?? this.scheme_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'scheme_name': scheme_name,
    };
  }

  factory SchemeModel.fromMap(Map<String, dynamic> map) {
    return SchemeModel(
      id: map['id']?.toInt() ?? 0,
      scheme_name: map['scheme_name'],
    );
  }
  static List<SchemeModel> fromJsonList(List list) {
    return list.map((e) => SchemeModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory SchemeModel.fromJson(String source) =>
      SchemeModel.fromMap(json.decode(source));

  @override
  String toString() => scheme_name;
}
