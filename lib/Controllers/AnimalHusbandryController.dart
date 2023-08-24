import 'package:agri_farmers_app/Models/AnimalHusbandryModel.dart';
import 'package:agri_farmers_app/Models/LivestockModel.dart';
import 'package:agri_farmers_app/Models/TypeOfBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfFarmModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryFarmModel.dart';
import 'package:agri_farmers_app/Services/AnimalHusbandryServices.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AnimalHusbandryController extends GetxController {
  AnimalHusbandryServices services = Get.find(tag: 'animalHusbandryServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isEdit = false.obs;
  //DATA
  var ids = 0.obs;
  var husbandryId = TextEditingController();
  var locationText = TextEditingController();
  var adultMaleText = TextEditingController();
  var adultMale = 0.obs;
  var adultFemaleText = TextEditingController();
  var adultFemale = 0.obs;
  var youngStockText = TextEditingController();
  var youngStock = 0.obs;
  var total = 0.obs;
  var noOfPoultryText = TextEditingController();
  var livestockList = [];
  var typeOfBreedList = [];
  var typeOfFarmList = [];
  var typeOfPoultryFarmList = [];
  var typeOfPoultryBreedList = [];
  var livestockData = <LivestockModel>[].obs;
  var typeOfFarmData = <TypeOfFarmModel>[].obs;
  var typeOfBreedData = <TypeOfBreedModel>[].obs;
  var typeOfPoultryFarmData = <TypeOfPoultryFarmModel>[].obs;
  var typeOfPoultryBreedData = <TypeOfPoultryBreedModel>[].obs;

  void submitHusbandry(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      var t = (adultMale.value + adultFemale.value + youngStock.value);
      var hus = AnimalHusbandryModel();
      hus.farmers_id = farmerId;
      hus.husbandry_id = husbandryId.text;
      hus.location = locationText.text;
      hus.adult_male = adultMale.value;
      hus.adult_female = adultFemale.value;
      hus.young_stock = youngStock.value;
      hus.total = t;
      hus.no_of_poultry = int.parse(noOfPoultryText.text);
      var data = await services.submitHusbandry(
          hus,
          livestockList,
          typeOfFarmList,
          typeOfBreedList,
          typeOfPoultryFarmList,
          typeOfPoultryBreedList);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  void getAnimalHusbandry(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.getAnimalHusbandry(id);
      ids.value = data.id!;
      husbandryId.text = data.husbandry_id!;
      locationText.text = data.location!;
      adultMaleText.text = data.adult_male.toString();
      adultMale.value = data.adult_male!;
      adultFemaleText.text = data.adult_female.toString();
      adultFemale.value = data.adult_female!;
      youngStockText.text = data.young_stock.toString();
      youngStock.value = data.young_stock!;
      total.value = data.total!;
      noOfPoultryText.text = data.no_of_poultry.toString();
      livestockList.clear();
      livestockList.addAll(data.livestock!.map((e) => e.id));
      livestockData.clear();
      livestockData.addAll(data.livestock!);
      typeOfBreedList.clear();
      typeOfBreedList.addAll(data.typeOfBreed!.map((e) => e.id));
      typeOfBreedData.clear();
      typeOfBreedData.addAll(data.typeOfBreed!);
      typeOfFarmList.clear();
      typeOfFarmList.addAll(data.typeOfFarm!.map((e) => e.id));
      typeOfFarmData.clear();
      typeOfFarmData.addAll(data.typeOfFarm!);

      typeOfPoultryBreedList.clear();
      typeOfPoultryBreedList.addAll(data.typeOfPoultryBreed!.map((e) => e.id));
      typeOfPoultryBreedData.clear();
      typeOfPoultryBreedData.addAll(data.typeOfPoultryBreed!);

      typeOfPoultryFarmList.clear();
      typeOfPoultryFarmList.addAll(data.typeOfPoultryFarm!.map((e) => e.id));
      typeOfPoultryFarmData.clear();
      typeOfPoultryFarmData.addAll(data.typeOfPoultryFarm!);
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  void updateAnimalHusbandry(int farmerId, Function onLoading,
      Function onSuccess, Function onError) async {
    onLoading();
    try {
      var t = (adultMale.value + adultFemale.value + youngStock.value);
      var hus = AnimalHusbandryModel();
      hus.id = ids.value;
      hus.farmers_id = farmerId;
      hus.husbandry_id = husbandryId.text;
      hus.location = locationText.text;
      hus.adult_male = adultMale.value;
      hus.adult_female = adultFemale.value;
      hus.young_stock = youngStock.value;
      hus.total = t;
      hus.no_of_poultry = int.parse(noOfPoultryText.text);
      var data = await services.updataAnimalHusbandry(
          ids.value,
          hus,
          livestockList,
          typeOfFarmList,
          typeOfBreedList,
          typeOfPoultryFarmList,
          typeOfPoultryBreedList);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  void deleteHusbandry(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var res = await services.deleteHusbandry(id);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
