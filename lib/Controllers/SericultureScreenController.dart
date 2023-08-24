import 'package:agri_farmers_app/Models/SericultureModel.dart';
import 'package:agri_farmers_app/Models/SilkwormModel.dart';
import 'package:agri_farmers_app/Services/SericultureScreenServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SericultureScreenController extends GetxController {
  SericultureScreenServices services =
      Get.find(tag: 'sericultureScreenServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var isEdit = false.obs;
  //DATA
  var ids = 0.obs;
  var sericultureId = TextEditingController();
  var location = TextEditingController();
  var totalArea = TextEditingController();
  var sizeOfRearingUnit = TextEditingController();
  var plantationTotalArea = TextEditingController();
  var silkwormRearedList = [];
  var silkwormRearedData = <SilkwormModel>[].obs;

  void submitSericulture(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      var seri = SericultureModel();
      seri.farmers_id = farmerId;
      seri.sericulture_id = sericultureId.text;
      seri.location = location.text;
      seri.total_area = totalArea.text;
      seri.size_of_rearing_unit = sizeOfRearingUnit.text;
      seri.plantation_total_area = plantationTotalArea.text;
      var data = await services.submitSericulture(seri, silkwormRearedList);
      onSuccess();
    } catch (ex) {
      onError();
      print(ex);
    }
  }

  void getSericulture(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.getSericulture(id);
      ids.value = data.id!;
      sericultureId.text = data.sericulture_id!;
      location.text = data.location!;
      totalArea.text = data.total_area!;
      sizeOfRearingUnit.text = data.size_of_rearing_unit!;
      silkwormRearedList.clear();
      silkwormRearedList.addAll(data.silkworm!.map((e) => e.id));
      silkwormRearedData.clear();
      silkwormRearedData.addAll(data.silkworm!);
      plantationTotalArea.text = data.plantation_total_area!;
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  void updateSericulture(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      var seri = SericultureModel();
      seri.id = ids.value;
      seri.farmers_id = farmerId;
      seri.sericulture_id = sericultureId.text;
      seri.location = location.text;
      seri.total_area = totalArea.text;
      seri.size_of_rearing_unit = sizeOfRearingUnit.text;
      seri.plantation_total_area = plantationTotalArea.text;
      var data =
          await services.updateSericulture(ids.value, seri, silkwormRearedList);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  void deleteSericulture(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.deleteSericulture(id);
      print(data);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
