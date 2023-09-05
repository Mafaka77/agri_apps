import 'package:agri_farmers_app/Models/FarmerBankDetailModel.dart';
import 'package:get/get.dart';

import '../Models/FarmerModel.dart';
import '../Services/BasicInfoServices.dart';

class OfflineDataController extends GetxController {
  var farmerList = <FarmerModel>[].obs;
  BasicInfoServices services = Get.find(tag: 'basicInfoServices');
  @override
  void onInit() {
    getFarmers();
    // TODO: implement onInit
    super.onInit();
  }

  Future getFarmers() async {
    var farmers = await services.getAllFarmers();
    var data = FarmerModel.fromJsonList(farmers);
    farmerList.clear();
    farmerList.addAll(data);
  }

  Future getFarmerBankDetails(int id) async {
    var bankDetails = await services.getFarmerBankDetails(id);
    var data = FarmerBankDetailModel.fromJsonList(bankDetails);
  }
}
