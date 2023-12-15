import 'dart:math';

import 'package:agri_farmers_app/Models/CasteModel.dart';
import 'package:agri_farmers_app/Models/DistrictModel.dart';
import 'package:agri_farmers_app/Models/FarmerBankDetailModel.dart';
import 'package:agri_farmers_app/Models/FarmerCategoryModel.dart';
import 'package:agri_farmers_app/Models/GenderModel.dart';
import 'package:agri_farmers_app/Models/RdBlockModel.dart';
import 'package:agri_farmers_app/Models/SubDivisionModel.dart';
import 'package:agri_farmers_app/Models/VillageModel.dart';
import 'package:agri_farmers_app/Services/BasicInfoServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Models/FarmerModel.dart';

var storage = const FlutterSecureStorage();

class BasicInfoController extends GetxController {
  BasicInfoServices services = Get.find(tag: 'basicInfoServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var farmerId = 0.obs;
  var nameController = TextEditingController().obs;
  var fullNameTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var voterIdTextController = TextEditingController();
  var genderID = 0.obs;
  var relationshipType = ''.obs;
  var farmerCategoryID = 0.obs;
  var relationship = TextEditingController();
  var fatherNameTextController = TextEditingController();
  var familyMemberTextController = TextEditingController();
  var phoneNoTextController = TextEditingController();
  var districtID = 0.obs;
  var subDivisionID = 0.obs;
  var villageID = 0.obs;
  var qualificationTextController = TextEditingController();
  var occupationTextController = TextEditingController();
  var casteID = 0.obs;
  var aadhaarTextController = TextEditingController();
  var aadhaarVerifyType = 'Physically Verified'.obs;
  var bankNameTextController = TextEditingController();
  var accountNumberTextController = TextEditingController();
  var branchNameTextController = TextEditingController();
  var ifscTextController = TextEditingController();
  var isFarmingMainIncome = 'Yes'.obs;
  var rdBlockID = 0.obs;
  var casteValue = Rxn<CasteModel>();
  var genderValue = Rxn<GenderModel>();
  var categoryValue = Rxn<FarmerCategoryModel>();
  var districtValue = Rxn<DistrictModel>();
  var subDivisionValue = Rxn<SubDivisionModel>();
  var rdBlockValue = Rxn<RdBlockModel>();
  var villageValue = Rxn<VillageModel>();
  var villageLGDCode = ''.obs;
  //LIST OF DATAS
  var allGenderList = <GenderModel>[].obs;
  var districtIdForSubDivision = 0.obs;
  var districtIdForBlock = 0.obs;
  var blockIdForVillage = 0.obs;

  var checkIsEdit = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void saveFarmer(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    var family = FarmerModel();
    family.ids = randomNumber;
    family.full_name = nameController.value.text;
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
      var res = await services.SaveUser(family);
      bank.farmers_id = res;
      var bankDetails = await services.saveFarmerBankDetails(bank);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

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

  saveFarmerOnline(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    String? userId = await storage.read(key: 'userId');
    var family = FarmerModel();
    family.full_name = nameController.value.text;
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
    family.user_id = int.parse(userId.toString());
    family.block_id = rdBlockID.value;
    family.village_id = villageID.value;
    family.state_lgd_code = '15';
    family.village_lgd_code = villageLGDCode.value;
    family.status = 'Incomplete';
    var bank = FarmerBankDetailModel();
    bank.bank_name = bankNameTextController.text;
    bank.account_number = accountNumberTextController.text;
    bank.branch_name = branchNameTextController.text;
    bank.ifsc_code = ifscTextController.text;
    try {
      var data = await services.submitBasicInfo(family.toMap(), bank);
      onSuccess();
    } catch (ex) {
      debugPrint(ex.toString());
      onError();
    }
  }

  getFarmerBasicInfo(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.getFarmerBasicInfo(id);
      farmerId.value = id;
      nameController.value.text = data.full_name!;
      dobTextController.text = data.dob!;
      genderValue.value = data.gender;
      genderID.value = data.gender_id!;
      casteValue.value = data.caste;
      casteID.value = data.caste_id!;
      relationshipType.value = data.relationship!;
      relationship.text = data.relationship_name!;
      aadhaarTextController.text = data.aadhaar_no!;
      aadhaarVerifyType.value = data.aadhaar_verify_type!;
      phoneNoTextController.text = data.phone_no!;
      voterIdTextController.text = data.voter_no!;
      categoryValue.value = data.category!;
      farmerCategoryID.value = data.farmer_category_id!;
      qualificationTextController.text = data.education_qualification!;
      isFarmingMainIncome.value = data.is_farming_main_income!;
      districtValue.value = data.district!;
      districtID.value = data.district_id!;
      subDivisionValue.value = data.subDivision!;
      subDivisionID.value = data.sub_division_id!;
      rdBlockValue.value = data.rdBlock!;
      rdBlockID.value = data.block_id!;
      villageValue.value = data.village!;
      villageID.value = data.village_id!;
      bankNameTextController.text = data.bankDetail!.bank_name!;
      accountNumberTextController.text = data.bankDetail!.account_number!;
      branchNameTextController.text = data.bankDetail!.branch_name!;
      ifscTextController.text = data.bankDetail!.ifsc_code!;
      occupationTextController.text = data.other_income!;
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  editBasicInfo(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      String? userId = await storage.read(key: 'userId');
      var family = FarmerModel();
      family.full_name = nameController.value.text;
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
      family.user_id = int.parse(userId.toString());
      family.block_id = rdBlockID.value;
      family.village_id = villageID.value;
      family.state_lgd_code = '123';
      family.village_lgd_code = '1234';
      family.status = 'Incomplete';
      family.bank_name = bankNameTextController.text;
      family.account_number = accountNumberTextController.text;
      family.branch_name = branchNameTextController.text;
      family.ifsc_code = ifscTextController.text;
      var data = await services.editBasicInfo(farmerId.value, family.toMap());
      onSuccess(farmerId.value);
    } catch (ex) {
      onError();
    }
  }

  void deleteFarmer(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.deleteFarmer(id);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
