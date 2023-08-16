import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Helpers/Repository.dart';
import 'package:agri_farmers_app/Models/FarmerBankDetailModel.dart';
import 'package:agri_farmers_app/Models/FarmerModel.dart';

import '../Routes.dart';

class BasicInfoServices extends BaseService {
  late Repository repository;
  BasicInfoServices() {
    repository = Repository();
  }

  //Save User
  SaveUser(FarmerModel user) async {
    return await repository.insertData('farmers', user.toMap());
  }

  saveFarmerBankDetails(FarmerBankDetailModel bank) async {
    return await repository.insertData('farmers_bank_details', bank.toMap());
  }

  //Read All Users
  readAllUsers() async {
    return await repository.readData('farmers');
  }

  //Edit User
  UpdateUser(FarmerModel user) async {
    return await repository.updateData('users', user.toMap());
  }

  deleteUser(userId) async {
    return await repository.deleteDataById('users', userId);
  }

  //POPULATE DROPDOWN
  getRdBlock(int id) async {
    return await repository.getRdBlockByDistrictId('blocks', id);
  }

  getVillage(int id) async {
    return await repository.getVillageByRdBlock('villages', id);
  }

  //GET ALL FARMERS
  getAllFarmers() async {
    return await repository.getAllFarmers();
  }

  getFarmerBankDetails(int farmerId) async {
    return await repository.getFarmerBankDetails(
        'farmers_bank_details', farmerId);
  }

  //ONLINE
  submitBasicInfo(Object farmer) async {
    try {
      var response =
          await client.post(Routes.SUBMIT_FARMER_BASIC_INFO, data: farmer);
      print(response.statusCode);
      return response.statusCode;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<FarmerModel> getFarmerBasicInfo(int id) async {
    var response = await client.get(Routes.GET_FARMER(id));
    var data = response.data['farmer'];
    return FarmerModel.fromOnlineMap(data);
  }

  editBasicInfo(int id, Object farmer) async {
    print(farmer);
    try {
      var response = await client.put(
        Routes.UPDATE_FARMER_BASIC_INFO(id),
        data: farmer,
      );
      print(response);
    } catch (ex) {
      print(ex);
    }
  }

  deleteFarmer(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_FARMER(id));
      return response.data;
    } catch (ex) {
      return ex;
    }
  }
}
