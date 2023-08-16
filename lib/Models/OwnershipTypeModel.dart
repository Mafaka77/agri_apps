import 'dart:convert';

class OwnershipTypeModel {
  int id;
  String ownership_type_name;
  OwnershipTypeModel({
    required this.id,
    required this.ownership_type_name,
  });

  OwnershipTypeModel copyWith({
    int? id,
    String? ownership_type_name,
  }) {
    return OwnershipTypeModel(
      id: id ?? this.id,
      ownership_type_name: ownership_type_name ?? this.ownership_type_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownership_type_name': ownership_type_name,
    };
  }

  factory OwnershipTypeModel.fromMap(Map<String, dynamic> map) {
    return OwnershipTypeModel(
      id: map['id']?.toInt() ?? 0,
      ownership_type_name: map['ownership_type_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnershipTypeModel.fromJson(String source) =>
      OwnershipTypeModel.fromMap(json.decode(source));
  static List<OwnershipTypeModel> fromJsonList(List list) {
    return list.map((e) => OwnershipTypeModel.fromMap(e)).toList();
  }

  @override
  String toString() => ownership_type_name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnershipTypeModel &&
        other.id == id &&
        other.ownership_type_name == ownership_type_name;
  }

  @override
  int get hashCode => id.hashCode ^ ownership_type_name.hashCode;
}
