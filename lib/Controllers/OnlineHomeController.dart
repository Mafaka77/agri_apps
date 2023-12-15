import 'package:agri_farmers_app/Models/AgricultureFarmModel.dart';
import 'package:agri_farmers_app/Models/AnimalHusbandryModel.dart';
import 'package:agri_farmers_app/Models/FarmerAdditionalDetailModel.dart';
import 'package:agri_farmers_app/Models/FarmerModel.dart';
import 'package:agri_farmers_app/Models/FisheriesModel.dart';
import 'package:agri_farmers_app/Models/HorticultureModel.dart';
import 'package:agri_farmers_app/Models/LandWaterModel.dart';
import 'package:agri_farmers_app/Models/SericultureModel.dart';
import 'package:agri_farmers_app/Services/OnlineHomeScreenServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

var storage = const FlutterSecureStorage();

class OnlineHomeController extends GetxController {
  var storage = const FlutterSecureStorage();
  OnlineHomeScreenServices services = Get.find(tag: 'onlineHomeServices');
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var onlineFarmerList = <FarmerModel>[].obs;
  var farmerAgriLandList = <AgricultureLandModel>[].obs;
  var additionalDetails = <FarmerAdditionalDetailModel>[].obs;
  var horticultureList = <HorticultureModel>[].obs;
  var landWaterList = <LandWaterModel>[].obs;
  var fisherieList = <FisheriesModel>[].obs;
  var husbandryList = <AnimalHusbandryModel>[].obs;
  var sericultureList = <SericultureModel>[].obs;
  var isDataLoading = false.obs;
  var farmerOffset = 0.obs;
  var farmerLimit = 10.obs;
  var searchTextController = TextEditingController();
  var verification = ''.obs;
  //----
  var sortBy = ''.obs;
  var filterBy = ''.obs;
  //----------------------------------------------------------------------------
  @override
  void onInit() {
    getAllFarmers('');
    // TODO: implement onInit
    super.onInit();
  }

  checkVerification(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.checkVerification(id);
      verification.value = data;
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  sendForApproval(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.sendForApproval(id);
      verification.value = data;
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  checkStatus(int id) async {
    var data = await services.checkStatus(id);
    print(data);
  }

  getAllFarmers(String search) async {
    isDataLoading.value = true;
    int offset = 0;
    int limit = farmerLimit.value;
    try {
      var userId = await storage.read(key: 'userId');
      var data = await services.getAllFarmers(int.parse(userId.toString()),
          offset, limit, search, sortBy.value, filterBy.value);
      onlineFarmerList.clear();
      onlineFarmerList.addAll(data);
      isDataLoading.value = false;
      refreshController.refreshCompleted();
    } catch (ex) {
      print(ex);
    }
  }

  getFarmerFarmDetails(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      var data = await services.getFarmerFarmDetails(farmerId);
      var farm = AgricultureLandModel.fromJsonList(data['farms']);
      var additional =
          FarmerAdditionalDetailModel.fromJsonList(data['additional']);
      var horticulture = HorticultureModel.fromJsonList(data['horticulture']);
      var landWater = LandWaterModel.fromJsonList(data['landWater']);
      var fisheries = FisheriesModel.fromJsonList(data['fisheries']);
      var husbandry = AnimalHusbandryModel.fromJsonList(data['husbandry']);
      var sericulture = SericultureModel.fromJsonList(data['sericulture']);
      additionalDetails.clear();
      additionalDetails.addAll(additional);
      farmerAgriLandList.clear();
      farmerAgriLandList.addAll(farm);
      horticultureList.clear();
      horticultureList.addAll(horticulture);
      landWaterList.clear();
      landWaterList.addAll(landWater);
      fisherieList.clear();
      fisherieList.addAll(fisheries);
      husbandryList.clear();
      husbandryList.addAll(husbandry);
      sericultureList.clear();
      sericultureList.addAll(sericulture);
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  onLoadMore() async {
    isDataLoading.value = true;
    farmerOffset.value = farmerLimit.value;
    farmerLimit.value = farmerLimit.value + 10;
    try {
      var userId = await storage.read(key: 'userId');
      var data = await services.getAllFarmers(
        int.parse(userId.toString()),
        farmerOffset.value,
        farmerLimit.value,
        searchTextController.text,
        sortBy.value,
        filterBy.value,
      );
      if (data.isEmpty) {
        farmerOffset.value -= 10;
        farmerLimit.value -= 10;
      }
      onlineFarmerList.addAll(data);
      isDataLoading.value = false;
      refreshController.loadComplete();
    } catch (ex) {
      print(ex);
    }
  }

  getAllSupervisor(
      Function onLoading, Function onSuccess, Function onError) async {
    var districtId = await storage.read(key: 'district_id');
    onLoading();
    try {
      var response =
          await services.getAllSupervisor(int.parse(districtId.toString()));
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
