import 'dart:io';
import 'dart:math';

import 'package:agri_farmers_app/Models/AgricultureFarmModel.dart';
import 'package:agri_farmers_app/Models/DistrictModel.dart';
import 'package:agri_farmers_app/Models/FarmEquipmentModel.dart';
import 'package:agri_farmers_app/Models/IrrigationInfrastructure.dart';
import 'package:agri_farmers_app/Models/KharifCropModel.dart';
import 'package:agri_farmers_app/Models/LandHoldingModel.dart';
import 'package:agri_farmers_app/Models/OwnershipTypeModel.dart';
import 'package:agri_farmers_app/Models/RabiCropModel.dart';
import 'package:agri_farmers_app/Models/RdBlockModel.dart';
import 'package:agri_farmers_app/Models/SubDivisionModel.dart';
import 'package:agri_farmers_app/Models/VillageModel.dart';
import 'package:agri_farmers_app/Services/FarmLandServices.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class FarmLandController extends GetxController {
  FarmLandServices services = Get.find(tag: 'farmLandServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position? currentPosition;
  var centralFarmerIdTextController = TextEditingController();
  var landOwnerNameTextController = TextEditingController();
  var totalFarmAreaTextController = TextEditingController();
  var kharifTotalArea = TextEditingController();
  var rabiTotalArea = TextEditingController();
  var landHoldingID = 0.obs;
  var districtId = 0.obs;
  var subDivisionId = 0.obs;
  var rdBlockId = 0.obs;
  var villageId = 0.obs;
  var latitudeTextController = TextEditingController().obs;
  var longitudeTextController = TextEditingController().obs;
  var altitudeTextController = TextEditingController().obs;
  var ownershipTypeId = 0.obs;
  var landholdingNumberTextController = TextEditingController();
  var landholdingFileTextController = TextEditingController();
  var landholdingFile2TextController = TextEditingController();
  var oilPalmArea = TextEditingController();
  var oilPalmPlantation = 'No'.obs;
  var landholdingDocument = ''.obs;
  List infrastructure = [];
  List equipment = [];
  List kharifCrop = [];
  List rabiCrop = [];
  File? landholdingFile;
  File? landholdingFile2;

  var isLoading = false.obs;
  var isFile2Visible = false.obs;
  var isFilePicked = false.obs;

  var landHoldingData = Rxn<LandHoldingModel>();
  var districtValue = Rxn<DistrictModel>();
  var subDivisionValue = Rxn<SubDivisionModel>();
  var blockValue = Rxn<RdBlockModel>();
  var villageValue = Rxn<VillageModel>();
  var ownerTypeValue = Rxn<OwnershipTypeModel>();
  var infrastructureValue = <IrrigationInfrastructureModel>[].obs;
  var equipmentValue = <FarmEquipmentModel>[].obs;
  var kharifCropValue = <KharifCropModel>[].obs;
  var rabiCropValue = <RabiCropModel>[].obs;
  var agriFarmID = 0.obs;
  //DATAS
  var filePath = ''.obs;
  var districtIdForSubDivision = 0.obs;
  var districtIdForBlock = 0.obs;
  var blockIdForVillage = 0.obs;
  var isEdit = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
  }

  void submitFarmDetails(int farmersId) async {
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    var land = AgricultureLandModel();
    land.ids = randomNumber;
    land.farmers_id = farmersId;
    land.farmer_agri_id = centralFarmerIdTextController.text;
    land.land_owner_name = landOwnerNameTextController.text;
    land.area_of_land = totalFarmAreaTextController.text;
    land.land_holding_id = landHoldingID.value;
    land.district_id = districtId.value;
    land.acres_or_hectares = 'Acres';
    land.kharif_acres_or_hectares = 'Acres';
    land.rabi_acres_or_hectares = 'Acres';
    land.sub_division_id = subDivisionId.value;
    land.block_id = rdBlockId.value;
    land.village_id = villageId.value;
    land.ownership_type_id = ownershipTypeId.value;
    land.landholding_documents_number = landholdingNumberTextController.text;
    land.land_holding_file = landholdingFile!.path;
    land.latitude = latitudeTextController.value.text;
    land.longitude = longitudeTextController.value.text;
    land.altitude = altitudeTextController.value.text;
    land.rabi_total_area = rabiTotalArea.text;
    land.kharif_total_area = kharifTotalArea.text;
    print(land);
  }

  getCurrentLocation() {
    isLoading.value = true;
    geolocator.getCurrentPosition().then((Position position) {
      currentPosition = position;
      latitudeTextController.value.text = position.latitude.toString();
      longitudeTextController.value.text = position.longitude.toString();
      altitudeTextController.value.text = position.altitude.toString();
      isLoading.value = false;
      update();
    }).catchError((e) {
      print(e);
    });
  }

  uploadLandHoldingFile(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.uploadImageOnline(landholdingFile);
      print(data);
      isFilePicked.value = true;
      landholdingFileTextController.text = data;
      filePath.value = data;
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  submitOnlineAgricultureLand(int farmersId, Function onLoading,
      Function onSuccess, Function onError) async {
    onLoading();
    var land = AgricultureLandModel();
    land.farmers_id = farmersId;
    land.farmer_agri_id = centralFarmerIdTextController.text;
    land.land_owner_name = landOwnerNameTextController.text;
    land.area_of_land = totalFarmAreaTextController.text;
    land.land_holding_id = landHoldingID.value;
    land.district_id = districtId.value;
    land.acres_or_hectares = 'Acres';
    land.kharif_acres_or_hectares = 'Acres';
    land.rabi_acres_or_hectares = 'Acres';
    land.sub_division_id = subDivisionId.value;
    land.block_id = rdBlockId.value;
    land.land_holding_file = filePath.value;
    land.village_id = villageId.value;
    land.ownership_type_id = ownershipTypeId.value;
    land.landholding_documents_number = landholdingNumberTextController.text;
    land.latitude = latitudeTextController.value.text;
    land.longitude = longitudeTextController.value.text;
    land.altitude = altitudeTextController.value.text;
    land.rabi_total_area = rabiTotalArea.text;
    land.kharif_total_area = kharifTotalArea.text;
    land.oil_palm_plantation = oilPalmPlantation.value;
    land.oil_palm_area = oilPalmArea.text;
    try {
      var data = await services.submitFarmerAgriLand(
          land, infrastructure, equipment, kharifCrop, rabiCrop);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  getFarmerAgriLand(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();

    try {
      var data = await services.getFarmerAgriLand(id);
      print(data.oil_palm_plantation);
      agriFarmID.value = data.id!;
      centralFarmerIdTextController.text = data.farmer_agri_id!;
      landOwnerNameTextController.text = data.land_owner_name!;
      totalFarmAreaTextController.text = data.area_of_land!;
      latitudeTextController.value.text = '';
      latitudeTextController.value.text = data.latitude!;
      longitudeTextController.value.text = '';
      longitudeTextController.value.text = data.longitude!;
      altitudeTextController.value.text = '';
      altitudeTextController.value.text = data.altitude!;
      landHoldingData.value = data.landHolding;
      districtValue.value = data.district;
      subDivisionValue.value = data.subDivision;
      blockValue.value = data.block;
      villageValue.value = data.village;
      ownerTypeValue.value = data.ownershipType;
      landholdingNumberTextController.text = data.landholding_documents_number!;
      landholdingFileTextController.text = data.land_holding_file!;
      filePath.value = data.land_holding_file!;
      infrastructureValue.clear();
      infrastructureValue.addAll(data.infrastructure!);
      equipmentValue.clear();
      equipmentValue.addAll(data.equipment!);
      kharifCropValue.clear();
      kharifCropValue.addAll(data.kharifCrop!);
      rabiCropValue.clear();
      rabiCropValue.addAll(data.rabiCrop!);
      kharifTotalArea.text = data.kharif_total_area!;
      rabiTotalArea.text = data.rabi_total_area!;
      infrastructure.clear();
      infrastructure.addAll(data.infrastructure!.map((e) => e.id));
      equipment.clear();
      equipment.addAll(data.equipment!.map((e) => e.id));
      kharifCrop.clear();
      kharifCrop.addAll(data.kharifCrop!.map((e) => e.id));
      rabiCrop.clear();
      rabiCrop.addAll(data.rabiCrop!.map((e) => e.id));
      isEdit.value = true;
      districtId.value = data.district_id!;
      subDivisionId.value = data.sub_division_id!;
      rdBlockId.value = data.block_id!;
      villageId.value = data.village_id!;
      ownershipTypeId.value = data.ownership_type_id!;
      landHoldingID.value = data.land_holding_id!;
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  editAgriFarm(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    var land = AgricultureLandModel();
    land.id = agriFarmID.value;
    land.farmers_id = farmerId;
    land.farmer_agri_id = centralFarmerIdTextController.text;
    land.land_owner_name = landOwnerNameTextController.text;
    land.area_of_land = totalFarmAreaTextController.text;
    land.land_holding_id = landHoldingID.value;
    land.district_id = districtId.value;
    land.acres_or_hectares = 'Acres';
    land.kharif_acres_or_hectares = 'Acres';
    land.rabi_acres_or_hectares = 'Acres';
    land.sub_division_id = subDivisionId.value;
    land.land_holding_file = filePath.value;
    land.block_id = rdBlockId.value;
    land.village_id = villageId.value;
    land.ownership_type_id = ownershipTypeId.value;
    land.landholding_documents_number = landholdingNumberTextController.text;
    land.latitude = latitudeTextController.value.text;
    land.longitude = longitudeTextController.value.text;
    land.altitude = altitudeTextController.value.text;
    land.rabi_total_area = rabiTotalArea.text;
    land.kharif_total_area = kharifTotalArea.text;
    try {
      var data = await services.updateFarmerAgriLand(agriFarmID.value, land,
          infrastructure, equipment, kharifCrop, rabiCrop);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  editAgriFarmWithFile(var imagePath, int farmerId, Function onLoading,
      Function onSuccess, Function onError) async {
    print('With file');
    onLoading();
    var land = AgricultureLandModel();
    land.id = agriFarmID.value;
    land.farmers_id = farmerId;
    land.farmer_agri_id = centralFarmerIdTextController.text;
    land.land_owner_name = landOwnerNameTextController.text;
    land.area_of_land = totalFarmAreaTextController.text;
    land.land_holding_id = landHoldingID.value;
    land.district_id = districtId.value;
    land.acres_or_hectares = 'Acres';
    land.kharif_acres_or_hectares = 'Acres';
    land.rabi_acres_or_hectares = 'Acres';
    land.sub_division_id = subDivisionId.value;
    land.block_id = rdBlockId.value;
    land.land_holding_file = imagePath.toString();
    land.village_id = villageId.value;
    land.ownership_type_id = ownershipTypeId.value;
    land.landholding_documents_number = landholdingNumberTextController.text;
    land.latitude = latitudeTextController.value.text;
    land.longitude = longitudeTextController.value.text;
    land.altitude = altitudeTextController.value.text;
    land.rabi_total_area = rabiTotalArea.text;
    land.kharif_total_area = kharifTotalArea.text;
    try {
      var data = await services.updateFarmerAgriLand(agriFarmID.value, land,
          infrastructure, equipment, kharifCrop, rabiCrop);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
