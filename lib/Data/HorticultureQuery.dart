class HorticultureQuery {
  String orchardsTable = """
CREATE TABLE IF NOT EXISTS orchards(
  id INTEGER PRIMARY KEY,
  orchards_name VARCHAR
)
""";
  String plantationQuery = """
CREATE TABLE IF NOT EXISTS plantations(
  id INTEGER PRIMARY KEY,
  plantation_name VARCHAR
)
""";
  String greenHousePlantQuery = """
CREATE TABLE IF NOT EXISTS green_house_plants(
  id INTEGER PRIMARY KEY,
  name VARCHAR
)
""";
}
