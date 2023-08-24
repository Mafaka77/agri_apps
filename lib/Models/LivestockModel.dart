import 'dart:convert';

class LivestockModel {
  int? id;
  String? livestock_name;
  LivestockModel({
    this.id,
    this.livestock_name,
  });

  LivestockModel copyWith({
    int? id,
    String? livestock_name,
  }) {
    return LivestockModel(
      id: id ?? this.id,
      livestock_name: livestock_name ?? this.livestock_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'livestock_name': livestock_name,
    };
  }

  factory LivestockModel.fromMap(Map<String, dynamic> map) {
    return LivestockModel(
      id: map['id']?.toInt(),
      livestock_name: map['livestock_name'],
    );
  }
  static List<LivestockModel> fromJsonList(List list) {
    return list.map((e) => LivestockModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory LivestockModel.fromJson(String source) =>
      LivestockModel.fromMap(json.decode(source));

  @override
  String toString() => livestock_name!;
}
