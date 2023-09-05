import 'package:agri_farmers_app/Models/FarmerBankDetailModel.dart';
import 'package:agri_farmers_app/Models/FarmerModel.dart';

import '../../Helpers/Repository.dart';

class OfflineBasicInfoServices {
  late Repository repository;
  OfflineBasicInfoServices() {
    repository = Repository();
  }
  getAllCaste() async {
    return await repository.readData('castes');
  }

  getAllGender() async {
    return await repository.readData('genders');
  }

  getAllFarmerCategory() async {
    return await repository.readData('farmer_categories');
  }

  getDistrict(int id) async {
    return await repository.readDataById('districts', id);
  }

  getSubDivision(int id) async {
    return await repository.getSubDivision('sub_divisions', id);
  }

  getRdBlock(int id) async {
    return await repository.getRdBlockByDistrictId('blocks', id);
  }

  getVillage(int id) async {
    return await repository.getVillageByRdBlock('villages', id);
  }

  saveFarmer(FarmerModel farmerModel) async {
    return await repository.insertData('farmers', farmerModel.toMap());
  }

  saveFarmerBankDetails(FarmerBankDetailModel farmerBankDetailModel) async {
    return await repository.insertData(
        'farmers_bank_details', farmerBankDetailModel.toMap());
  }
}
