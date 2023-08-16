import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/CasteModel.dart';
import 'package:agri_farmers_app/Models/DistrictModel.dart';
import 'package:agri_farmers_app/Models/FarmerCategoryModel.dart';
import 'package:agri_farmers_app/Models/GenderModel.dart';
import 'package:agri_farmers_app/Models/SubDivisionModel.dart';
import 'package:agri_farmers_app/Routes.dart';

import '../Helpers/Repository.dart';

class HomeScreenServices extends BaseService {
  late Repository repository;
  HomeScreenServices() {
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

  getAllSubDivision() async {
    var response = await client.get(Routes.GET_ALL_SUB_DIVISION);
    var data = response.data;
    return data;
  }

  saveSubDivision(SubDivisionModel subDivisionModel) async {
    return await repository.insertData(
        'sub_divisions', subDivisionModel.toMap());
  }

  getSubDivision() async {
    return await repository.readData('sub_divisions');
  }
}
