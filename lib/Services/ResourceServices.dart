import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/FarmEquipmentModel.dart';
import 'package:agri_farmers_app/Models/FishModel.dart';
import 'package:agri_farmers_app/Models/GreenHouseModel.dart';
import 'package:agri_farmers_app/Models/IrrigationInfrastructure.dart';
import 'package:agri_farmers_app/Models/KharifCropModel.dart';
import 'package:agri_farmers_app/Models/LandCrops.dart';
import 'package:agri_farmers_app/Models/LandHoldingModel.dart';
import 'package:agri_farmers_app/Models/LivestockModel.dart';
import 'package:agri_farmers_app/Models/OrchardModel.dart';
import 'package:agri_farmers_app/Models/OwnershipTypeModel.dart';
import 'package:agri_farmers_app/Models/PlantationModel.dart';
import 'package:agri_farmers_app/Models/RabiCropModel.dart';
import 'package:agri_farmers_app/Models/RdBlockModel.dart';
import 'package:agri_farmers_app/Models/SchemeModel.dart';
import 'package:agri_farmers_app/Models/SilkwormModel.dart';
import 'package:agri_farmers_app/Models/TypeOfBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfFarmModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryFarmModel.dart';
import 'package:agri_farmers_app/Models/VillageModel.dart';

import '../Helpers/Repository.dart';
import '../Models/CasteModel.dart';
import '../Models/DistrictModel.dart';
import '../Models/FarmerCategoryModel.dart';
import '../Models/GenderModel.dart';
import '../Models/SubDivisionModel.dart';
import '../Routes.dart';

class ResourceServices extends BaseService {
  late Repository repository;
  ResourceServices() {
    repository = Repository();
  }

  //District
  saveDistrict(DistrictModel districtModel) async {
    return await repository.insertData('districts', districtModel.toMap());
  }

  getAllDistrict() async {
    return await repository.readData('districts');
  }

  UpdateUser(DistrictModel user) async {
    return await repository.updateData('users', user.toMap());
  }

  deleteUser(userId) async {
    return await repository.deleteDataById('users', userId);
  }

  //FARMER CATEGORY
  saveCategory(FarmerCategoryModel farmerCategoryModel) async {
    return await repository.insertData(
        'farmer_categories', farmerCategoryModel.toMap());
  }

  getAllFarmerCategory() async {
    return await repository.readData('farmer_categories');
  }

  //GENDER
  saveGender(GenderModel genderModel) async {
    return await repository.insertData('genders', genderModel.toMap());
  }

  getAllGender() async {
    return await repository.readData('genders');
  }

  //CASTE
  saveCaste(CasteModel casteModel) async {
    return await repository.insertData('castes', casteModel.toMap());
  }

  getAllCaste() async {
    return await repository.readData('castes');
  }

  //SUB DIVISION
  //API CALLS

  Future getAllResources() async {
    try {
      var response = await client.get(Routes.GET_ALL_RESOURCES);
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  clearAllTable() async {
    await repository.deleteTable('sub_divisions');
    await repository.deleteTable('blocks');
    await repository.deleteTable('villages');
    await repository.deleteTable('land_holdings');
    await repository.deleteTable('ownership_types');
    await repository.deleteTable('irrigation_infrastructures');
    await repository.deleteTable('farm_equipment');
    await repository.deleteTable('kharif_crops');
    await repository.deleteTable('rabi_crops');
    await repository.deleteTable('schemes');
    await repository.deleteTable('orchards');
    await repository.deleteTable('plantations');
    await repository.deleteTable('green_house_plants');
    await repository.deleteTable('land_crops');
  }

  getAllSubDivision() async {
    try {
      var response = await client.get(Routes.GET_ALL_SUB_DIVISION);
      var data = response.data;
      return data;
    } catch (ex) {
      return ex;
    }
  }

  saveSubDivision(SubDivisionModel subDivisionModel) async {
    return await repository.insertData(
        'sub_divisions', subDivisionModel.toMap());
  }

  getSubDivision() async {
    return await repository.readData('sub_divisions');
  }

  //BLOCK
  getAllRdBlock() async {
    var response = await client.get(Routes.GET_RD_BLOCK);
    var data = response.data;
    return data;
  }

  saveRDBlock(RdBlockModel rdBlockModel) async {
    return await repository.insertData('blocks', rdBlockModel.toMap());
  }

  //VILLAGE
  getAllVillage() async {
    var response = await client.get(Routes.GET_VILLAGE);
    var data = response.data;
    return data;
  }

  saveVillage(VillageModel villageModel) async {
    return await repository.insertData('villages', villageModel.toMap());
  }

  //LAND HOLDING
  getAllLandHolding() async {
    var response = await client.get(Routes.GET_ALL_LANDHOLDING);
    var data = response.data;
    return data;
  }

  saveLandHolding(LandHoldingModel landHoldingModel) async {
    return await repository.insertData(
        'land_holdings', landHoldingModel.toMap());
  }

  //OWNERSHIP TYPE
  getAllOwnershipType() async {
    var response = await client.get(Routes.GET_ALL_OWNERSHIP_TYPE);
    var data = response.data;
    return data;
  }

  saveOwnershipType(OwnershipTypeModel ownershipTypeModel) async {
    return await repository.insertData(
        'ownership_types', ownershipTypeModel.toMap());
  }

  //IRRIGATION INFRASTRUCTURE
  getAllIrrigationInfrastructure() async {
    var response = await client.get(Routes.GET_ALL_IRRIGATION_INFRASTRUCTURE);
    var data = response.data;
    return data;
  }

  saveIrrigationInfrastructure(
      IrrigationInfrastructureModel infrastructureModel) async {
    return await repository.insertData(
        'irrigation_infrastructures', infrastructureModel.toMap());
  }

  //FARM EQUIPMENT
  getAllFarmEquipment() async {
    var response = await client.get(Routes.GET_ALL_FARM_EQUIPMENT);
    var data = response.data;
    return data;
  }

  saveFarmEquipment(FarmEquipmentModel farmEquipmentModel) async {
    return await repository.insertData(
        'farm_equipment', farmEquipmentModel.toMap());
  }

  //KHARIF CROPS
  getAllKharifCrops() async {
    var response = await client.get(Routes.GET_ALL_KHARIF_CROPS);
    var data = response.data;
    return data;
  }

  saveKharifCrops(KharifCropModel kharifCropModel) async {
    return await repository.insertData('kharif_crops', kharifCropModel.toMap());
  }

  //RABI CROPS
  getAllRabiCrops() async {
    var response = await client.get(Routes.GET_ALL_RABI_CROPS);
    var data = response.data;
    return data;
  }

  saveRabiCrops(RabiCropModel rabiCropModel) async {
    return await repository.insertData('rabi_crops', rabiCropModel.toMap());
  }

  //SCHEME
  getAllScheme() async {
    var response = await client.get(Routes.GET_ALL_SCHEME);
    var data = response.data;
    return data;
  }

  saveScheme(SchemeModel schemeModel) async {
    return await repository.insertData('schemes', schemeModel.toMap());
  }

  //HORTICULTURE DATA
  Future getHorticultureData() async {
    try {
      var response = await client.get(Routes.GET_HORTICULTURE_DATA);
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  saveOrchards(OrchardModel orchardModel) async {
    return await repository.insertData('orchards', orchardModel.toMap());
  }

  savePlantation(PlantationModel plantationModel) async {
    return await repository.insertData('plantations', plantationModel.toMap());
  }

  saveGreenHouse(GreenHouseModel greenHouseModel) async {
    return await repository.insertData(
        'green_house_plants', greenHouseModel.toMap());
  }

  //LAND WATER CROPS
  Future getLandCrops() async {
    try {
      var response = await client.get(Routes.GET_LAND_CROPS);
      return response.data;
    } catch (ex) {}
  }

  saveLandCrop(LandCrops landCrops) async {
    return await repository.insertData('land_crops', landCrops.toMap());
  }

  //FIsh
  saveFish(FishModel fishModel) async {
    return await repository.insertData('fish', fishModel.toMap());
  }

  //LIVESTOCK
  saveLivestock(LivestockModel livestockModel) async {
    return await repository.insertData('livestocks', livestockModel.toMap());
  }

  //TYPE OF BREED
  saveTypeOfBreed(TypeOfBreedModel typeOfBreedModel) async {
    return await repository.insertData(
        'type_of_breeds', typeOfBreedModel.toMap());
  }

  //TYPE OF FARM
  saveTypeOfFarm(TypeOfFarmModel typeOfFarmModel) async {
    return await repository.insertData(
        'type_of_farms', typeOfFarmModel.toMap());
  }

  //TYPE OF POULTRY BREED
  savePoultryBreed(TypeOfPoultryBreedModel typeOfPoultryBreedModel) async {
    return await repository.insertData(
        'type_of_poultry_breeds', typeOfPoultryBreedModel.toMap());
  }

  //TYPE OF POULTRY FARM
  savePoultryFarm(TypeOfPoultryFarmModel typeOfPoultryFarmModel) async {
    return await repository.insertData(
        'type_of_poultry_farms', typeOfPoultryFarmModel.toMap());
  }

  //SILKWORM
  saveSilkworm(SilkwormModel silkwormModel) async {
    return await repository.insertData('silkworms', silkwormModel.toMap());
  }
}
