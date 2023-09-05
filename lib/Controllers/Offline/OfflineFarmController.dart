import 'dart:io';

import 'package:agri_farmers_app/Services/Offline/OfflineFarmServices.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../Models/AgricultureFarmModel.dart';

class OfflineFarmController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position? currentPosition;
  OfflineFarmServices services = Get.find(tag: 'offlineFarmServices');
  var centralFarmerId = TextEditingController();
  var landOwnerName = TextEditingController();
  var totalFarmArea = TextEditingController();
  var latitude = TextEditingController().obs;
  var longitude = TextEditingController().obs;
  var altitude = TextEditingController().obs;
  var landHoldingId = 0.obs;
  var districtId = 0.obs;
  var subDivisionId = 0.obs;
  var rdBlockId = 0.obs;
  var villageId = 0.obs;
  var ownershipTypeId = 0.obs;
  var landHoldingNumber = TextEditingController();
  var landholdingFileTextController = TextEditingController();
  List infrastructure = [];
  List equipment = [];
  List kharifCrop = [];
  List rabiCrop = [];
  var kharifTotalArea = TextEditingController();
  var rabiTotalArea = TextEditingController();
  var oilPalmArea = TextEditingController();
  var oilPalmPlantation = 'No'.obs;

  //VATS
  var isLoading = false.obs;
  var districtIdForBlock = 0.obs;
  var blockIdForVillage = 0.obs;
  File? landholdingFile;
  var isFilePicked = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
  }

  submitFarmLand(int farmerId) async {
    var farmModel = AgricultureLandModel();
    farmModel.farmers_id = farmerId;
    farmModel.farmer_agri_id = centralFarmerId.text;
    farmModel.land_owner_name = landOwnerName.text;
    farmModel.area_of_land = totalFarmArea.text;
    farmModel.latitude = latitude.value.text;
    farmModel.longitude = longitude.value.text;
    farmModel.altitude = altitude.value.text;
    farmModel.land_holding_id = landHoldingId.value;
    farmModel.district_id = districtId.value;
    farmModel.sub_division_id = subDivisionId.value;
    farmModel.block_id = rdBlockId.value;
    farmModel.village_id = villageId.value;
    farmModel.ownership_type_id = ownershipTypeId.value;
    farmModel.landholding_documents_number = landHoldingNumber.text;
    farmModel.acres_or_hectares = 'Acres';
    farmModel.kharif_acres_or_hectares = 'Acres';
    farmModel.rabi_acres_or_hectares = 'Acres';
    farmModel.land_holding_file = landholdingFile!.path;
    farmModel.kharif_total_area = kharifTotalArea.text;
    farmModel.rabi_total_area = rabiTotalArea.text;
    farmModel.oil_palm_plantation = oilPalmPlantation.value;
    farmModel.oil_palm_area = oilPalmArea.text;

    var data = await services.submitFarmLand(farmModel);
  }

  getCurrentLocation() {
    isLoading.value = true;
    geolocator.getCurrentPosition().then((Position position) {
      currentPosition = position;
      latitude.value.text = position.latitude.toString();
      longitude.value.text = position.longitude.toString();
      altitude.value.text = position.altitude.toString();
      isLoading.value = false;
      update();
    }).catchError((e) {
      print(e);
    });
  }
}
