class GenderData {
  List genderList = [
    {'id': 1, 'gender_name': 'Male'},
    {'id': 2, 'gender_name': 'Female'}
  ];
  String genderTable =
      "CREATE TABLE IF NOT EXISTS genders(id INTEGER PRIMARY KEY, gender_name VARCHAR)";
}
