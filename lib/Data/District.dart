class District {
  List districts = [
    {'id': 1, 'district_name': 'Aizawl'},
    {'id': 2, 'district_name': 'Lunglei'},
    {'id': 3, 'district_name': 'Saiha'},
    {'id': 4, 'district_name': 'Champhai'},
    {'id': 5, 'district_name': 'Kolasib'},
    {'id': 6, 'district_name': 'Serchhip'},
    {'id': 7, 'district_name': 'Lawngtlai'},
    {'id': 8, 'district_name': 'Mamit'},
    {'id': 9, 'district_name': 'Saitual'},
    {'id': 10, 'district_name': 'Khawzawl'},
    {'id': 11, 'district_name': 'Hnahthial'},
  ];
  String districtTable =
      "CREATE TABLE IF NOT EXISTS districts(id INTEGER PRIMARY KEY,district_name VARCHAR)";
  String subDivisiontable =
      "CREATE TABLE IF NOT EXISTS sub_divisions(id INTEGER PRIMARY KEY,sub_division_name VARCHAR)";
  String rdBlockTable =
      "CREATE TABLE IF NOT EXISTS blocks(id INTEGER PRIMARY KEY,block_name VARCHAR,district_id INTEGER)";

  String villageTable =
      "CREATE TABLE IF NOT EXISTS villages(id INTEGER PRIMARY KEY,village_name VARCHAR,village_lgd_code VARCHAR,block_id INTEGER)";
}
