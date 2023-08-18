class Routes {
  // static String BASE_URL = 'http://192.168.29.6:8000/api/';
  static String BASE_URL = 'http://10.180.243.103:8000/api/';

  //LOGIN
  static String LOGIN = '${BASE_URL}login';
  //RESOURCE
  static String GET_ALL_GENDER = '${BASE_URL}get-all-gender';
  static String GET_ALL_CASTE = '${BASE_URL}get-all-caste';
  static String GET_ALL_FARMER_CATEGORY = '${BASE_URL}get-all-category';
  static String GET_ALL_DISTRICT = '${BASE_URL}get-all-district';
  static String GET_ALL_SUB_DIVISION = '${BASE_URL}get-all-subDivision';
  static String GET_RD_BLOCK = '${BASE_URL}get-rd-block';
  static String GET_VILLAGE = '${BASE_URL}get-village';
  static String GET_ALL_LANDHOLDING = '${BASE_URL}get-all-landholding';
  static String GET_ALL_OWNERSHIP_TYPE = '${BASE_URL}get-all-ownership-type';
  static String GET_ALL_IRRIGATION_INFRASTRUCTURE =
      '${BASE_URL}get-all-irrigation-infrastructure';
  static String GET_ALL_FARM_EQUIPMENT = '${BASE_URL}get-all-farm-equipment';
  static String GET_ALL_KHARIF_CROPS = '${BASE_URL}get-all-kharif-crops';
  static String GET_ALL_RABI_CROPS = '${BASE_URL}get-all-rabi-crops';
  static String GET_ALL_SCHEME = '${BASE_URL}get-all-scheme';
  static String GET_HORTICULTURE_DATA = '${BASE_URL}get-horticulture-data';
  static String GET_LAND_CROPS = '${BASE_URL}get-land-crops';

  //ONLINE DATA
  static String GET_ALL_FARMERS(id) => '${BASE_URL}get-all-farmers/$id';
  static String SUBMIT_FARMER_BASIC_INFO =
      '${BASE_URL}submit-farmer-basic-info';
  static String GET_FARMER(id) => '${BASE_URL}get-farmer/$id';
  static String GET_AGRI_FARM(id) => '${BASE_URL}get-agri-farm/$id';
  static String UPLOAD_LANDHOLDING_FILE = '${BASE_URL}upload-landholding-file';
  static String SUBMIT_AGRI_FARM = '${BASE_URL}submit-agri-farm';
  static String GET_FARMER_AGRI_LAND(id) =>
      '${BASE_URL}get-agri-farm-detail/$id';
  static String UPDATE_FARMER_AGRI_LAND(id) =>
      '${BASE_URL}update-farm-detail/$id';
  static String UPLOAD_ADDITIONAL_FILE = '${BASE_URL}upload-additional-file';
  static String SUBMIT_ADDITIONAL_DETAILS =
      '${BASE_URL}submit-additional-details';
  static String CHECK_STATUS(id) => '${BASE_URL}check-status/$id';
  static String UPDATE_FARMER_BASIC_INFO(farmerId) =>
      '${BASE_URL}update-farmer-basic-info/$farmerId';
  static String DELETE_FARMER(id) => '${BASE_URL}delete-farmer/$id';
  static String GET_ADDITIONAL_DETAIL(id) =>
      '${BASE_URL}get-additional-details/$id';
  static String GET_FARMER_SCHEME(id) => '${BASE_URL}get-farmer-schemes/$id';
  static String UPDATE_ADDITIONAL_DETAILS(id) =>
      '${BASE_URL}update-additional-details/$id';
  static String DELETE_ADDITIONAL_DETAIL(id) =>
      '${BASE_URL}delete-additional-detail/$id';
  static String CHECK_VERIFICATION(int id) =>
      '${BASE_URL}check-verification/$id';
  static String SEND_FOR_APPROVAL(id) => '${BASE_URL}send-for-approval/$id';

  //HORTICULTURE
  static String SUBMIT_HORTI_DETAILS = '${BASE_URL}submit-farmer-horticulture';
  static String GET_HORTI_DETAIL(id) =>
      '${BASE_URL}get-horticulture-detail/$id';
  static String UPDATE_HORTI_DETAILS(id) =>
      '${BASE_URL}update-horticulture-details/$id';
  static String DELETE_HORTICULTURE(id) =>
      '${BASE_URL}delete-horticulture-details/$id';

  //LAND WATER CONSERVATOIN
  static String SUBMIT_LAND_WATER = '${BASE_URL}submit-land-water';
  static String GET_LAND_WATER(id) => '${BASE_URL}get-land-water/$id';
  static String UPDATE_LAND_WATER(id) => '${BASE_URL}update-land-water/$id';
}
