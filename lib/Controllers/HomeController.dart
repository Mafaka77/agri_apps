import 'package:agri_farmers_app/Data/District.dart';
import 'package:agri_farmers_app/Models/FarmerModel.dart';
import 'package:agri_farmers_app/Services/HomeScreenServices.dart';
import 'package:get/get.dart';

import '../Services/BasicInfoServices.dart';

class HomeController extends GetxController {
  BasicInfoServices services = Get.find(tag: 'basicInfoServices');
  HomeScreenServices homeScreenServices = Get.find(tag: 'homeScreenServices');
  District district = District();
  var farmerList = <FarmerModel>[].obs;
  var isOnlineDataVisible = true.obs;
  var isOfflineDataVisible = false.obs;
  List subDivision = [];
  @override
  void onInit() {
    getFarmers();
    super.onInit();
  }

  Future getFarmers() async {
    var farmers = await services.readAllUsers();
    var data = FarmerModel.fromJsonList(farmers);
    farmerList.addAll(data);
  }
}
