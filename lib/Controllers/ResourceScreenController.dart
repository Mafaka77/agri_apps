import 'package:agri_farmers_app/Data/ResourceQuery.dart';
import 'package:agri_farmers_app/Models/FarmEquipmentModel.dart';
import 'package:agri_farmers_app/Models/IrrigationInfrastructure.dart';
import 'package:agri_farmers_app/Models/KharifCropModel.dart';
import 'package:agri_farmers_app/Models/LandCrops.dart';
import 'package:agri_farmers_app/Models/OwnershipTypeModel.dart';
import 'package:agri_farmers_app/Models/RabiCropModel.dart';
import 'package:agri_farmers_app/Models/RdBlockModel.dart';
import 'package:agri_farmers_app/Models/SchemeModel.dart';
import 'package:agri_farmers_app/Models/VillageModel.dart';
import 'package:agri_farmers_app/Services/ResourceServices.dart';
import 'package:get/get.dart';

import '../Data/Caste.dart';
import '../Data/District.dart';
import '../Data/GenderData.dart';
import '../Models/CasteModel.dart';
import '../Models/DistrictModel.dart';
import '../Models/FarmerCategoryModel.dart';
import '../Models/FarmerModel.dart';
import '../Models/GenderModel.dart';
import '../Models/GreenHouseModel.dart';
import '../Models/LandHoldingModel.dart';
import '../Models/OrchardModel.dart';
import '../Models/PlantationModel.dart';
import '../Models/SubDivisionModel.dart';

class ResourceScreenController extends GetxController {
  ResourceServices resourceServices = Get.find(tag: 'resourceServices');
  District district = District();
  var farmerList = <FarmerModel>[].obs;
  List subDivision = [];

  // PERMISSION
  var cameraPermission = false.obs;
  var microphonePermission = false.obs;
  var memoryPermission = false.obs;
  var locationPermission = false.obs;
  @override
  void onInit() {
    submitDistrict();
    submitCategory();
    submitGender();
    submitCaste();
    getAllSubDivision();
    getAllRdBlock();
    getAllVillage();
    getLandHolding();
    getAllOwnershipType();
    getAllIrrigationInfrastructure();
    getAllFarmEquipment();
    getAllKharifCrops();
    getAllRabiCrops();
    getAllScheme();
    getHorticultureData();
    getLandCrops();
    super.onInit();
  }

  void submitDistrict() async {
    for (var data in district.districts) {
      var dis =
          DistrictModel(id: data['id'], district_name: data['district_name']);
      await resourceServices.saveDistrict(dis);
    }
  }

  void submitCategory() async {
    for (var data in ResourceQuery().farmerCategory) {
      var fa = FarmerCategoryModel(
          id: data['id'], f_category_name: data['f_category_name']);
      await resourceServices.saveCategory(fa);
    }
  }

  void submitGender() async {
    for (var data in GenderData().genderList) {
      var fa = GenderModel(id: data['id'], gender_name: data['gender_name']);
      await resourceServices.saveGender(fa);
    }
  }

  void submitCaste() async {
    for (var data in CasteData().casteList) {
      var fa = CasteModel(id: data['id'], caste: data['caste']);
      await resourceServices.saveCaste(fa);
    }
  }

  getAllSubDivision() async {
    var res = await resourceServices.getAllSubDivision();
    for (var data in res) {
      var fa = SubDivisionModel(
          id: data['id'], sub_division_name: data['sub_division_name']);
      await resourceServices.saveSubDivision(fa);
    }
  }

  getAllRdBlock() async {
    var res = await resourceServices.getAllRdBlock();

    for (var data in res) {
      var da = RdBlockModel(
          id: data['id'],
          block_name: data['block_name'],
          district_id: data['district_id']);
      await resourceServices.saveRDBlock(da);
    }
  }

  getAllVillage() async {
    var res = await resourceServices.getAllVillage();
    for (var data in res) {
      var da = VillageModel(
          id: data['id'],
          village_name: data['village_name'],
          village_lgd_code: data['village_lgd_code'],
          block_id: data['block_id']);
      await resourceServices.saveVillage(da);
    }
  }

  getLandHolding() async {
    var res = await resourceServices.getAllLandHolding();
    for (var data in res) {
      var land = LandHoldingModel(
          id: data['id'], land_holding_name: data['land_holding_name']);
      await resourceServices.saveLandHolding(land);
    }
  }

  getAllOwnershipType() async {
    var res = await resourceServices.getAllOwnershipType();
    for (var data in res) {
      var ownership = OwnershipTypeModel(
          id: data['id'], ownership_type_name: data['ownership_type_name']);
      await resourceServices.saveOwnershipType(ownership);
    }
  }

  getAllIrrigationInfrastructure() async {
    var res = await resourceServices.getAllIrrigationInfrastructure();
    for (var data in res) {
      var irr = IrrigationInfrastructureModel(
          id: data['id'],
          irrigation_infrastructures_name:
              data['irrigation_infrastructures_name']);
      await resourceServices.saveIrrigationInfrastructure(irr);
    }
  }

  getAllFarmEquipment() async {
    var res = await resourceServices.getAllFarmEquipment();
    for (var data in res) {
      var farm = FarmEquipmentModel(
          id: data['id'], equipment_name: data['equipment_name']);
      await resourceServices.saveFarmEquipment(farm);
    }
  }

  getAllKharifCrops() async {
    var res = await resourceServices.getAllKharifCrops();
    for (var data in res) {
      var kharif = KharifCropModel(
          id: data['id'], kharif_crops_name: data['kharif_crops_name']);
      await resourceServices.saveKharifCrops(kharif);
    }
  }

  getAllRabiCrops() async {
    var res = await resourceServices.getAllRabiCrops();
    for (var data in res) {
      var rabi = RabiCropModel(
          id: data['id'], rabi_crops_name: data['rabi_crops_name']);
      await resourceServices.saveRabiCrops(rabi);
    }
  }

  getAllScheme() async {
    var res = await resourceServices.getAllScheme();
    for (var data in res) {
      var scheme =
          SchemeModel(id: data['id'], scheme_name: data['scheme_name']);
      await resourceServices.saveScheme(scheme);
    }
  }

  getHorticultureData() async {
    var res = await resourceServices.getHorticultureData();
    var orchards = res['orchards'];
    var plantation = res['plantation'];
    var greenHouse = res['greenHouse'];
    for (var data in orchards) {
      var orchards =
          OrchardModel(id: data['id'], orchards_name: data['orchards_name']);
      await resourceServices.saveOrchards(orchards);
    }

    for (var data in plantation) {
      var plantation = PlantationModel(
          id: data['id'], plantation_name: data['plantation_name']);
      await resourceServices.savePlantation(plantation);
    }
    for (var data in greenHouse) {
      var greenHouse = GreenHouseModel(id: data['id'], name: data['name']);
      await resourceServices.saveGreenHouse(greenHouse);
    }
  }

  getLandCrops() async {
    var res = await resourceServices.getLandCrops();
    var landCrops = res['crops'];
    for (var land in landCrops) {
      var data = LandCrops(id: land['id'], crop_name: land['crop_name']);
      await resourceServices.saveLandCrop(data);
    }
  }
}
