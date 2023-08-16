class GenderModel {
  int id;
  String gender_name;
  GenderModel({
    required this.id,
    required this.gender_name,
  });

  factory GenderModel.fromMap(Map<String, dynamic> map) {
    return GenderModel(
      id: map['id']?.toInt() ?? 0,
      gender_name: map['gender_name'],
    );
  }
  static List<GenderModel> fromJsonList(List list) {
    return list.map((e) => GenderModel.fromMap(e)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '$id $gender_name';
  }

  ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return this.createdAt.toString().contains(filter);
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(GenderModel model) {
    return id == model.id;
  }

  @override
  String toString() => gender_name;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gender_name': gender_name,
    };
  }
}
