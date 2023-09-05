import 'dart:math';

import 'package:agri_farmers_app/Services/Offline/OfflineBasicInfoServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Models/CasteModel.dart';
import '../../Models/DistrictModel.dart';
import '../../Models/FarmerBankDetailModel.dart';
import '../../Models/FarmerCategoryModel.dart';
import '../../Models/FarmerModel.dart';
import '../../Models/GenderModel.dart';
import '../../Models/RdBlockModel.dart';
import '../../Models/SubDivisionModel.dart';
import '../../Models/VillageModel.dart';

class OfflineBasicInfoController extends GetxController {
  OfflineBasicInfoServices services = Get.find(tag: 'offlineBasicInfoServices');
  //DATA
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var dobTextController = TextEditingController();
  var casteValue = Rxn<CasteModel>();
  var casteID = 0.obs;
  var genderValue = Rxn<GenderModel>();
  var genderID = 0.obs;
  var relationshipType = ''.obs;
  var relationship = TextEditingController();
  var aadhaarTextController = TextEditingController();
  var aadhaarVerifyType = 'Physically Verified'.obs;
  var phoneNoTextController = TextEditingController();
  var voterIdTextController = TextEditingController();
  var categoryValue = Rxn<FarmerCategoryModel>();
  var farmerCategoryID = 0.obs;
  var qualificationTextController = TextEditingController();
  var isFarmingMainIncome = 'Yes'.obs;
  var occupationTextController = TextEditingController();
  var districtValue = Rxn<DistrictModel>();
  var districtID = 0.obs;
  var districtIdForSubDivision = 0.obs;
  var districtIdForBlock = 0.obs;
  var blockIdForVillage = 0.obs;
  var subDivisionValue = Rxn<SubDivisionModel>();
  var subDivisionID = 0.obs;
  var rdBlockValue = Rxn<RdBlockModel>();
  var villageValue = Rxn<VillageModel>();
  var rdBlockID = 0.obs;
  var villageID = 0.obs;
  var bankNameTextController = TextEditingController();
  var accountNumberTextController = TextEditingController();
  var branchNameTextController = TextEditingController();
  var ifscTextController = TextEditingController();

  //----
  var checkIsEdit = false.obs;

  pickDOB(BuildContext context) async {
    try {
      var datePicked = await DatePicker.showSimpleDatePicker(
        context,
        initialDate: DateTime(1994),
        firstDate: DateTime(1960),
        lastDate: DateTime(2012),
        dateFormat: "dd-MMMM-yyyy",
        locale: DateTimePickerLocale.en_us,
        looping: true,
      );
      var date = DateFormat('dd/MM/yyyy').format(datePicked!);
      dobTextController.text = date;
    } catch (ex) {}
  }

  void saveFarmer(
      Function onLoading, Function onSuccess, Function onError) async {
    print('Hello');
    onLoading();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    var family = FarmerModel();
    family.ids = randomNumber;
    family.full_name = fullNameController.text;
    family.dob = dobTextController.text;
    family.caste_id = casteID.value;
    family.gender_id = genderID.value;
    family.relationship = relationshipType.value;
    family.relationship_name = relationship.text;
    family.aadhaar_no = aadhaarTextController.text;
    family.aadhaar_verify_type = aadhaarVerifyType.value;
    family.phone_no = phoneNoTextController.text;
    family.voter_no = voterIdTextController.text;
    family.farmer_category_id = farmerCategoryID.value;
    family.education_qualification = qualificationTextController.text;
    family.is_farming_main_income = isFarmingMainIncome.value;
    family.other_income = occupationTextController.text;
    family.district_id = districtID.value;
    family.sub_division_id = subDivisionID.value;
    family.user_id = 1;
    family.block_id = rdBlockID.value;
    family.village_id = villageID.value;
    family.state_lgd_code = '123';
    family.status = 'Incomplete';
    var bank = FarmerBankDetailModel();
    bank.bank_name = bankNameTextController.text;
    bank.account_number = accountNumberTextController.text;
    bank.branch_name = branchNameTextController.text;
    bank.ifsc_code = ifscTextController.text;

    try {
      print(family);
      var res = await services.saveFarmer(family);
      bank.farmers_id = res;
      var bankDetails = await services.saveFarmerBankDetails(bank);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
