import 'package:agri_farmers_app/Models/LandCrops.dart';
import 'package:agri_farmers_app/Models/LandWaterModel.dart';
import 'package:agri_farmers_app/Services/LandWaterScreenServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandWaterScreenController extends GetxController {
  LandWaterScreenServices services = Get.find(tag: 'landWaterScreenServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isEdit = false.obs;
  //DATA
  var ownerID = TextEditingController();
  var location = TextEditingController();
  var cropsGrown = [];
  var totalArea = TextEditingController();
  var cropsGrownData = <LandCrops>[].obs;
  var landWaterId = 0.obs;

  submitLandWater(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      var land = LandWaterModel();
      land.farmers_id = farmerId;
      land.owner_id = ownerID.text;
      land.location = location.text;
      land.crops_acres_or_hectares = 'Acres';
      land.total_area = totalArea.text;
      var res = await services.submitLandWater(land, cropsGrown);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  getLandWaterData(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.getLandWater(id);
      landWaterId.value = data.id!;
      ownerID.text = data.owner_id!;
      location.text = data.location!;
      totalArea.text = data.total_area!;
      cropsGrownData.clear();
      cropsGrownData.addAll(data.crops!);
      cropsGrown.clear();
      cropsGrown.addAll(data.crops!.map((e) => e.id));
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  updateLandWater(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      var land = LandWaterModel();
      land.id = landWaterId.value;
      land.farmers_id = farmerId;
      land.owner_id = ownerID.text;
      land.location = location.text;
      land.crops_acres_or_hectares = 'Acres';
      land.total_area = totalArea.text;
      var res =
          await services.updateLandWater(landWaterId.value, land, cropsGrown);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
