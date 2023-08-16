class AgriLandData {
  String landHoldingTable =
      "CREATE TABLE IF NOT EXISTS land_holdings (id INTEGER PRIMARY KEY,land_holding_name VARCHAR)";
  String ownershipType =
      "CREATE TABLE IF NOT EXISTS ownership_types(id INTEGER PRIMARY KEY,ownership_type_name VARCHAR)";
  String irrigationInfrastructureTable =
      "CREATE TABLE IF NOT EXISTS irrigation_infrastructures(id INTEGER PRIMARY KEY,irrigation_infrastructures_name VARCHAR)";
  String farmEquipmentTable =
      "CREATE TABLE IF NOT EXISTS farm_equipment(id INTREGER PRIMARY KEY,equipment_name VARCHAR)";
  String kharifCropTable =
      "CREATE TABLE IF NOT EXISTS kharif_crops(id INTEGER PRIMARY KEY,kharif_crops_name VARCHAR)";
  String rabiCropTable =
      "CREATE TABLE IF NOT EXISTS rabi_crops(id INTEGER PRIMARY KEY, rabi_crops_name VARCHAR)";
  String farmerIrrigationInfrastructure =
      """CREATE TABLE IF NOT EXISTS farmer_irrigation_infrastructures
      (
      id INTEGER PRIMARY KEY,
      irrigation_infrastructures_id INTEGER,
      farmer_agriculture_land_details_id INTEGER

      )""";
  String farmerFarmEquipment =
      """CREATE TABLE IF NOT EXISTS farmer_farm_equipment
      (
      id INTEGER PRIMARY KEY,
      farm_equipment_id INTEGER,
      farmer_agriculture_land_details_id INTEGER
      )""";
  String farmerKharifCrops = """CREATE TABLE IF NOT EXISTS farmer_kharif_crops
      (
      id INTEGER PRIMARY KEY,
      kharif_crops_id INTEGER,
      farmer_agriculture_land_details_id INTEGER
      )""";
  String farmerRabiCrops = """CREATE TABLE IF NOT EXISTS farmer_kharif_crops
      (
      id INTEGER PRIMARY KEY,
      rabi_crops_id INTEGER,
      farmer_agriculture_land_details_id INTEGER
      )""";
  String farmerAgricultureLand = """
CREATE TABLE IF NOT EXISTS farmer_agriculture_land_details(
  id INTEGER PRIMARY KEY,
  ids INTEGER,
  farmer_agri_id VARCHAR,
  land_owner_name VARCHAR,
  area_of_land VARCHAR,
  acres_or_hectares VARCHAR,
  latitude VARCHAR,
  longitude VARCHAR,
  altitude VARCHAR,
  landholding_documents_number VARCHAR,
  landholding_file TEXT,
  other_irrigation_infrastructure VARCHAR,
  other_farm_equipment VARCHAR,
  kharif_acres_or_hectares VARCHAR,
  kharif_total_area VARCHAR,
  rabi_acres_or_hectares VARCHAR,
  rabi_total_area VARCHAR,
  farmers_id INTEGER,
  district_id INTEGER,
  sub_division_id INTEGER,
  block_id INTEGER,
  village_id INTEGER,
  land_holding_id INTEGER,
  ownership_type_id INTEGER
)
""";
}
