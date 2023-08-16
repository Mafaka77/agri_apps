class CasteData {
  List casteList = [
    {'id': 1, 'caste': 'ST'},
    {'id': 2, 'caste': 'SC'},
    {'id': 3, 'caste': 'OBC'},
    {'id': 4, 'caste': 'GENERAL'}
  ];

  String casteTable =
      "CREATE TABLE IF NOT EXISTS castes(id INTEGER PRIMARY KEY, caste VARCHAR)";
}
