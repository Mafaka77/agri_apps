class ResourceQuery {
  List farmerCategory = [
    {'id': 1, 'f_category_name': 'Landless'},
    {'id': 2, 'f_category_name': 'Marginal(<1 Ha)'},
    {'id': 3, 'f_category_name': 'Small(1-2 Ha)'},
    {'id': 4, 'f_category_name': 'Semi-Medium (2-4 Ha)'},
    {'id': 5, 'f_category_name': 'Medium (4-10 Ha)'},
    {'id': 6, 'f_category_name': 'Medium (10+ Ha)'},
  ];
  String farmersTable = "CREATE TABLE IF NOT EXISTS farmers("
      "id INTEGER,"
      "ids INTEGER PRIMARY KEY,"
      "full_name VARCHAR,"
      "dob VARCHAR,"
      "relationship VARCHAR,"
      "relationship_name VARCHAR,"
      "phone_no VARCHAR,"
      "aadhaar_no VARCHAR,"
      "aadhaar_verify_type VARCHAR,"
      "voter_no VARCHAR,"
      "education_qualification VARCHAR,"
      "is_farming_main_income VARCHAR,"
      "other_income VARCHAR,"
      "state_lgd_code VARCHAR,"
      "village_lgd_code VARCHAR,"
      "status VARCHAR,"
      "user_id INTEGER,"
      "farmer_category_id INTEGER,"
      "gender_id INTEGER,"
      "caste_id INTEGER,"
      "district_id INTEGER,"
      "sub_division_id INTEGER,"
      "block_id INTEGER,"
      "village_id INTEGER,"
      "FOREIGN KEY (farmer_category_id) REFERENCES farmer_categories (id)"
      "FOREIGN KEY (gender_id) REFERENCES genders (id)"
      "FOREIGN KEY (caste_id) REFERENCES castes (id)"
      "FOREIGN KEY (sub_division_id) REFERENCES sub_divisions (id)"
      "FOREIGN KEY (block_id) REFERENCES blocks (id)"
      "FOREIGN KEY (village_id) REFERENCES villages (id)"
      "FOREIGN KEY (district_id) REFERENCES districts (id));";

  String farmerCategoryTable = """CREATE TABLE IF NOT EXISTS farmer_categories(
          id INTEGER PRIMARY KEY,
          f_category_name VARCHAR
          );""";

  String farmerBankDetails = """
CREATE TABLE IF NOT EXISTS farmers_bank_details(
  id INTEGER PRIMARY KEY,
  bank_name VARCHAR,
  branch_name VARCHAR,
  account_number VARCHAR,
  ifsc_code VARCHAR,
  farmers_id INTEGER
  )
""";
}
