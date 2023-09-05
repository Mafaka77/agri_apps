import 'package:agri_farmers_app/Models/GreenHouseModel.dart';
import 'package:agri_farmers_app/Models/HorticultureModel.dart';
import 'package:agri_farmers_app/Models/KharifCropModel.dart';
import 'package:agri_farmers_app/Models/OrchardModel.dart';
import 'package:agri_farmers_app/Models/PlantationModel.dart';
import 'package:agri_farmers_app/Models/RabiCropModel.dart';
import 'package:agri_farmers_app/Services/HorticultureScreenServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

var storage = const FlutterSecureStorage();

class HorticultureScreenController extends GetxController {
  HorticultureScreenServices services = Get.find(tag: 'horticultureServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isEdit = false.obs;
  //FORMS
  var hortiFarmerIdTextController = TextEditingController();
  var locationTextController = TextEditingController();
  var kharifTotalAreaTextController = TextEditingController();
  var rabiTotalAreaTextController = TextEditingController();
  var greenHouseTotalAreaTextController = TextEditingController();
  var hortiId = 0.obs;
  List kharifCrops = [];
  List rabiCrops = [];
  List orchards = [];
  List plantation = [];
  List greenHouse = [];
  //DATA
  var kharifCropsData = <KharifCropModel>[].obs;
  var rabiCropsData = <RabiCropModel>[];
  var orchardsData = <OrchardModel>[];
  var plantationData = <PlantationModel>[];
  var greenHouseData = <GreenHouseModel>[];

  void submitHortiDetails(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    var horti = HorticultureModel();
    horti.farmers_id = farmerId;
    horti.farmer_horticulture_id = hortiFarmerIdTextController.text;
    horti.location = locationTextController.text;
    horti.kharif_acres_or_hectares = 'Acres';
    horti.kharif_total_area = kharifTotalAreaTextController.text;
    horti.rabi_acres_or_hectares = 'Acres';
    horti.rabi_total_area = rabiTotalAreaTextController.text;
    horti.total_greenhouse_area = greenHouseTotalAreaTextController.text;
    try {
      var data = await services.submitHortiDetails(
          horti, kharifCrops, rabiCrops, orchards, plantation, greenHouse);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  getHortiDetails(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.getHortiDetail(id);
      hortiId.value = data.id!;
      hortiFarmerIdTextController.text = data.farmer_horticulture_id!;
      locationTextController.text = data.location!;
      kharifTotalAreaTextController.text = data.kharif_total_area!;
      rabiTotalAreaTextController.text = data.rabi_total_area!;
      greenHouseTotalAreaTextController.text = data.total_greenhouse_area!;
      kharifCropsData.clear();
      kharifCropsData.addAll(data.kharifCrop!.map((e) => e));
      rabiCropsData.clear();
      rabiCropsData.addAll(data.rabiCrops!.map((e) => e));
      orchardsData.clear();
      orchardsData.addAll(data.orchards!.map((e) => e));
      plantationData.clear();
      plantationData.addAll(data.plantation!.map((e) => e));
      greenHouseData.clear();
      greenHouseData.addAll(data.grenhouse!.map((e) => e));
      kharifCrops.clear();
      kharifCrops.addAll(data.kharifCrop!.map((e) => e.id));
      rabiCrops.clear();
      rabiCrops.addAll(data.rabiCrops!.map((e) => e.id));
      orchards.clear();
      orchards.addAll(data.orchards!.map((e) => e.id));
      plantation.clear();
      plantation.addAll(data.plantation!.map((e) => e.id));
      greenHouse.clear();
      greenHouse.addAll(data.grenhouse!.map((e) => e.id));
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  updateHortiDetails(int id, int farmerId, Function onLoading,
      Function onSuccess, Function onError) async {
    onLoading();
    try {
      var horti = HorticultureModel();
      horti.id = id;
      horti.farmers_id = farmerId;
      horti.farmer_horticulture_id = hortiFarmerIdTextController.text;
      horti.location = locationTextController.text;
      horti.kharif_acres_or_hectares = 'Acres';
      horti.kharif_total_area = kharifTotalAreaTextController.text;
      horti.rabi_acres_or_hectares = 'Acres';
      horti.rabi_total_area = rabiTotalAreaTextController.text;
      horti.total_greenhouse_area = greenHouseTotalAreaTextController.text;
      var data = await services.updateHortiDetails(
          id, horti, kharifCrops, rabiCrops, orchards, plantation, greenHouse);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  deleteHorticulture(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    try {
      var response = await services.deleteHorticulture(id);
      response == 200 ? onSuccess() : onError();
    } catch (ex) {
      onError();
    }
  }
}
