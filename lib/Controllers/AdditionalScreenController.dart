import 'dart:io';

import 'package:agri_farmers_app/Models/SchemeModel.dart';
import 'package:agri_farmers_app/Services/AdditionalScreenServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Models/FarmerAdditionalDetailModel.dart';

var storage = const FlutterSecureStorage();

class AdditionalScreenController extends GetxController {
  AdditionalScreenServices services = Get.find(tag: 'additionalScreenServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var schemes = <SchemeModel>[].obs;
  var schemeId = 0.obs;
  var schemeName = ''.obs;
  var availed = 'Yes'.obs;
  var amount = ''.obs;
  var isRationCardPicked = false.obs;
  var isAadhaarCardPicked = false.obs;
  var isBankPassbookPicked = false.obs;
  var isEdit = false.obs;
  //FORMS

  var rationCardNumberTextController = TextEditingController();
  var rationCardFileNameTextController = TextEditingController();
  File? rationCardFile;
  var schemeApplied = [].obs;
  var kccCardNumberTextController = TextEditingController();
  var kccRenewTextController = TextEditingController();
  var kccBankNameTextController = TextEditingController();
  var kccBranchTextController = TextEditingController();
  var kccYearOfSanctionedTextController = TextEditingController();
  var kccSanctionedAmountTextController = TextEditingController();
  var aadhaarCardFileTextController = TextEditingController();
  File? aadhaarCardFile;
  var bankPassbookFileTextController = TextEditingController();
  File? bankPassbookFile;
  var dateTextController = TextEditingController();
  var remarksTextController = TextEditingController();
  var isKCCAvailed = 'No'.obs;

  pickDOB(BuildContext context) async {
    try {
      var datePicked = await DatePicker.showSimpleDatePicker(
        context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
        dateFormat: "dd-MMMM-yyyy",
        locale: DateTimePickerLocale.en_us,
        looping: true,
      );
      var date = DateFormat('dd/MM/yyyy').format(datePicked!);
      dateTextController.text = date;
    } catch (ex) {}
  }

  uploadRationCardFile(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.uploadDocuments(rationCardFile);
      rationCardFileNameTextController.text = data;
      isRationCardPicked.value = true;
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  uploadAadhaarCardFile(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.uploadDocuments(aadhaarCardFile);
      aadhaarCardFileTextController.text = data;
      isAadhaarCardPicked.value = true;
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  uploadBankPassbookFile(
      Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.uploadDocuments(bankPassbookFile);
      bankPassbookFileTextController.text = data;
      isBankPassbookPicked.value = true;
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  submitAddtionalDetails(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      var additional = FarmerAdditionalDetailModel();
      additional.ration_card_number = rationCardNumberTextController.text;
      additional.ration_card_path = rationCardFileNameTextController.text;
      additional.is_kcc_availed = isKCCAvailed.value == 'Yes' ? 1 : 0;
      additional.kcc_card_no = kccCardNumberTextController.text;
      additional.kcc_renew_or_new = kccRenewTextController.text;
      additional.bank_name = kccBankNameTextController.text;
      additional.branch_name = kccBranchTextController.text;
      additional.year_of_amount_sanction =
          kccYearOfSanctionedTextController.text;
      additional.amount_sanction = kccSanctionedAmountTextController.text;
      additional.aadhaar_card_path = aadhaarCardFileTextController.text;
      additional.bank_passbook_path = bankPassbookFileTextController.text;
      additional.date_of_data_collection = dateTextController.text;
      additional.remarks = remarksTextController.text;
      additional.farmers_id = farmerId;
      var data =
          await services.submitAdditionalDetails(additional, schemeApplied);
      print(data);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  getAdditionalDetails(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.getAdditionalDetails(id);
      rationCardNumberTextController.text = data.ration_card_number!;
      rationCardFileNameTextController.text = data.ration_card_path!;
      isKCCAvailed.value = data.is_kcc_availed == 0 ? 'No' : 'Yes';
      kccCardNumberTextController.text = data.kcc_card_no!;
      kccRenewTextController.text = data.kcc_renew_or_new!;
      kccBankNameTextController.text = data.bank_name!;
      kccBranchTextController.text = data.branch_name!;
      kccYearOfSanctionedTextController.text = data.year_of_amount_sanction!;
      kccSanctionedAmountTextController.text = data.amount_sanction!;
      aadhaarCardFileTextController.text = data.aadhaar_card_path!;
      bankPassbookFileTextController.text = data.bank_passbook_path!;
      dateTextController.text = data.date_of_data_collection!;
      remarksTextController.text = data.remarks!;
      getFarmerScheme(data.id!);
      isEdit.value = true;
      onSuccess();
    } catch (ex) {
      print(ex);
      onError();
    }
  }

  getFarmerScheme(int id) async {
    try {
      var data = await services.getFarmerScheme(id);
      schemeApplied.clear();
      for (var d in data) {
        schemeApplied.add({
          'scheme_id': d.schemes_id.toString(),
          'scheme_name': d.schemeModel!.scheme_name.toString(),
          'availed': d.availed == 1 ? 'Yes' : 'No'.toString(),
          'amount': d.amount.toString(),
        });
      }
    } catch (ex) {
      print(ex);
    }
  }

  updateAdditionalDetails(int id, int farmerId, Function onLoading,
      Function onSuccess, Function onError) async {
    onLoading();
    try {
      var additional = FarmerAdditionalDetailModel();
      additional.id = id;
      additional.ration_card_number = rationCardNumberTextController.text;
      additional.ration_card_path = rationCardFileNameTextController.text;
      additional.is_kcc_availed = isKCCAvailed.value == 'Yes' ? 1 : 0;
      additional.kcc_card_no = kccCardNumberTextController.text;
      additional.kcc_renew_or_new = kccRenewTextController.text;
      additional.bank_name = kccBankNameTextController.text;
      additional.branch_name = kccBranchTextController.text;
      additional.year_of_amount_sanction =
          kccYearOfSanctionedTextController.text;
      additional.amount_sanction = kccSanctionedAmountTextController.text;
      additional.aadhaar_card_path = aadhaarCardFileTextController.text;
      additional.bank_passbook_path = bankPassbookFileTextController.text;
      additional.date_of_data_collection = dateTextController.text;
      additional.remarks = remarksTextController.text;
      additional.farmers_id = farmerId;
      var data =
          await services.updateAdditionalDetail(id, additional, schemeApplied);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  deleteAdditionalDetail(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.deleteAdditionalDetail(id);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
