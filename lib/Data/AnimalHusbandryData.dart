class AnimalHusbandry {
  String livestockTable =
      'CREATE TABLE IF NOT EXISTS livestocks(id INTEGER PRIMARY KEY, livestock_name VARCHAR)';
  String typeOfBreedTable =
      'CREATE TABLE IF NOT EXISTS type_of_breeds(id INTEGER PRIMARY KEY,name VARCHAR)';
  String typeOfFarmTable =
      'CREATE TABLE IF NOT EXISTS type_of_farms(id INTEGER PRIMARY KEY, name VARCHAR)';
  String typeOfPoultryFarmTable =
      'CREATE TABLE IF NOT EXISTS type_of_poultry_farms(id INTEGER PRIMARY KEY, name VARCHAR)';
  String typeOfPoultryBreedTable =
      'CREATE TABLE IF NOT EXISTS type_of_poultry_breeds(id INTEGER PRIMARY KEY,name VARCHAR)';
}
