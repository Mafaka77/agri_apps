class CasteModel {
  int id;
  String caste;
  CasteModel({
    required this.id,
    required this.caste,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'caste': caste,
    };
  }

  factory CasteModel.fromMap(Map<String, dynamic> map) {
    return CasteModel(
      id: map['id']?.toInt() ?? 0,
      caste: map['caste'],
    );
  }
  static List<CasteModel> fromJsonList(List list) {
    return list.map((e) => CasteModel.fromMap(e)).toList();
  }

  @override
  String toString() => caste;
}
