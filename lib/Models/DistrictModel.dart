class DistrictModel {
  int id;
  String district_name;
  DistrictModel({
    required this.id,
    required this.district_name,
  });

  String userAsString() {
    return '#$id $district_name';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'district_name': district_name,
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      id: map['id']?.toInt() ?? 0,
      district_name: map['district_name'],
    );
  }

  static List<DistrictModel> fromJsonList(List list) {
    return list.map((e) => DistrictModel.fromMap(e)).toList();
  }

  @override
  String toString() => district_name;
}
