import 'dart:convert';

class FarmerCategoryModel {
  int id;
  String f_category_name;
  FarmerCategoryModel({
    required this.id,
    required this.f_category_name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'f_category_name': f_category_name,
    };
  }

  factory FarmerCategoryModel.fromMap(Map<String, dynamic> map) {
    return FarmerCategoryModel(
      id: map['id'],
      f_category_name: map['f_category_name'],
    );
  }

  String toJson() => json.encode(toMap());

  static List<FarmerCategoryModel> fromJsonList(List list) {
    return list.map((e) => FarmerCategoryModel.fromMap(e)).toList();
  }

  @override
  String toString() => f_category_name;
}
