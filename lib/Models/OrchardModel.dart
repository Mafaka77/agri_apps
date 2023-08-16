import 'dart:convert';

class OrchardModel {
  int? id;
  String? orchards_name;
  OrchardModel({
    this.id,
    this.orchards_name,
  });

  OrchardModel copyWith({
    int? id,
    String? orchards_name,
  }) {
    return OrchardModel(
      id: id ?? this.id,
      orchards_name: orchards_name ?? this.orchards_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orchards_name': orchards_name,
    };
  }

  factory OrchardModel.fromMap(Map<String, dynamic> map) {
    return OrchardModel(
      id: map['id']?.toInt(),
      orchards_name: map['orchards_name'],
    );
  }
  static List<OrchardModel> fromJsonList(List list) {
    return list.map((e) => OrchardModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory OrchardModel.fromJson(String source) =>
      OrchardModel.fromMap(json.decode(source));

  @override
  String toString() => orchards_name!;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrchardModel &&
        other.id == id &&
        other.orchards_name == orchards_name;
  }

  @override
  int get hashCode => id.hashCode ^ orchards_name.hashCode;
}
