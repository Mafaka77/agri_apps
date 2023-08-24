import 'package:agri_farmers_app/Controllers/BasicInfoController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Models/DistrictModel.dart';
import 'package:agri_farmers_app/Models/FarmerCategoryModel.dart';
import 'package:agri_farmers_app/Models/GenderModel.dart';
import 'package:agri_farmers_app/Models/RdBlockModel.dart';
import 'package:agri_farmers_app/Models/SubDivisionModel.dart';
import 'package:agri_farmers_app/Models/VillageModel.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/BasicInfoServices.dart';
import 'package:agri_farmers_app/Services/HomeScreenServices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../Models/CasteModel.dart';
import '../../MyColors.dart';

class OnlineAddBasicInfoScreen extends StatelessWidget {
  OnlineAddBasicInfoScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  HomeScreenServices screenServices = Get.find(tag: 'homeScreenServices');
  BasicInfoServices basicInfoServices = Get.find(tag: 'basicInfoServices');
  OnlineHomeController onlineHomeController = Get.find();
  var storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicInfoController>(
        init: BasicInfoController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                backgroundColor: MyColors.deepGreen),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    elevation: 0,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.deepGreen),
                        borderRadius: BorderRadius.circular(20)),
                    minWidth: Get.width * 0.4,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(color: MyColors.deepGreen),
                    ),
                  ),
                  Obx(() {
                    return controller.checkIsEdit.isTrue
                        ? MaterialButton(
                            elevation: 0,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            color: MyColors.deepGreen,
                            minWidth: Get.width * 0.4,
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.editBasicInfo(() {
                                  reusableWidget.loader(context);
                                }, (int farmerId) {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                      'Farmer Basic Info Updated',
                                      const Icon(
                                        Icons.check,
                                        color: Colors.blue,
                                      ));
                                  onlineHomeController.getAllFarmers('');
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                      'Error Occured!! Try Again',
                                      const Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ));
                                });
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : MaterialButton(
                            elevation: 0,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            color: MyColors.deepGreen,
                            minWidth: Get.width * 0.4,
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.saveFarmerOnline(() {
                                  reusableWidget.loader(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                      'Farmer Basic Info Submitted',
                                      const Icon(
                                        Icons.check,
                                        color: Colors.blue,
                                      ));
                                  onlineHomeController.getAllFarmers('');
                                  Navigator.pop(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                      'Error Occured!! Try Again',
                                      const Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ));
                                });
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                  })
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          controller: controller.nameController.value,
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            errorBorder: reusableWidget.errorBorderStyle(),
                            focusedErrorBorder:
                                reusableWidget.errorBorderStyle(),
                            label: Text(
                              'Full Name',
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (val) =>
                            val != '' ? null : 'Required field *',
                        onTap: () {
                          controller.pickDOB(context);
                        },
                        controller: controller.dobTextController,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          focusedErrorBorder: reusableWidget.errorBorderStyle(),
                          labelText: 'Date of Birth',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<CasteModel>(
                          selectedItem: controller.casteValue.value,
                          validator: (val) {
                            if (val == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Caste',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              focusedErrorBorder:
                                  reusableWidget.errorBorderStyle(),
                            ),
                          ),
                          asyncItems: (String filter) async {
                            var response = await screenServices.getAllCaste();
                            var data = CasteModel.fromJsonList(response);
                            return data;
                          },
                          onChanged: (data) {
                            controller.casteID.value = data!.id;
                            controller.update();
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<GenderModel>(
                          selectedItem: controller.genderValue.value,
                          validator: (val) {
                            if (val == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              contentPadding: const EdgeInsets.all(10),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              labelText: 'Gender',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          asyncItems: (String filter) async {
                            var response = await screenServices.getAllGender();
                            var data = GenderModel.fromJsonList(response);
                            return data;
                          },
                          onChanged: (data) {
                            controller.genderID.value = data!.id;
                            controller.update();
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<String>(
                          selectedItem: controller.relationshipType.value,
                          validator: (val) {
                            if (val == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          items: const [
                            "Father's Name",
                            "Wife Name",
                            "Husband Name",
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Relationship Type',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          onChanged: (val) {
                            controller.relationshipType.value = val.toString();
                            controller.update();
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.relationship,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          label: Text(
                            'Father/Wife Husband Name',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.aadhaarTextController,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          label: Text(
                            'Aadhaar Card',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<String>(
                        selectedItem: controller.aadhaarVerifyType.value,
                        validator: (val) {
                          if (val == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        items: const [
                          "Physically Verified",
                          "Online Verified",
                        ],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            errorBorder: reusableWidget.errorBorderStyle(),
                            labelText: 'Aadhaar Verification Type',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        onChanged: (val) {
                          controller.aadhaarVerifyType.value = val.toString();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 10) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.phoneNoTextController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_android,
                            color: MyColors.deepGreen,
                          ),
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          focusedErrorBorder: reusableWidget.errorBorderStyle(),
                          label: Text(
                            'Phone No',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.voterIdTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          label: Text(
                            'Voter ID',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<FarmerCategoryModel>(
                          selectedItem: controller.categoryValue.value,
                          validator: (val) {
                            if (val == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Farmer Category',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          asyncItems: (String filter) async {
                            var response =
                                await screenServices.getAllFarmerCategory();
                            var data =
                                FarmerCategoryModel.fromJsonList(response);
                            return data;
                          },
                          onChanged: (data) {
                            controller.farmerCategoryID.value = data!.id;
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.qualificationTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          label: Text(
                            'Highest Qualification',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      Text(
                        'Is Farming the main source of income?',
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      Obx(
                        () => RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          horizontalAlignment: MainAxisAlignment.start,
                          groupValue: controller.isFarmingMainIncome.value,
                          onChanged: (value) {
                            controller.isFarmingMainIncome.value =
                                value.toString();
                            if (value == 'Yes') {
                              controller.occupationTextController.clear();
                            }
                          },
                          items: const ['Yes', 'No'],
                          itemBuilder: (item) => RadioButtonBuilder(item),
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(() {
                        return controller.isFarmingMainIncome.value == 'No'
                            ? TextFormField(
                                controller: controller.occupationTextController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: reusableWidget.borderStyle(),
                                  focusedBorder: reusableWidget.borderStyle(),
                                  label: Text(
                                    'Other Income',
                                    style: reusableWidget.textBoxTextSyle(),
                                  ),
                                ),
                                style: reusableWidget.textBoxTextSyle(),
                              )
                            : Container();
                      }),
                      reusableWidget.textBoxSpace(),
                      const Text('Address'),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<DistrictModel>(
                          selectedItem: controller.districtValue.value,
                          validator: (value) {
                            if (value == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Select District',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          asyncItems: (String filter) async {
                            var districtId =
                                await storage.read(key: 'district_id');
                            var res = await screenServices
                                .getDistrict(int.parse(districtId.toString()));
                            var data = DistrictModel.fromJsonList(res);
                            return data;
                          },
                          onChanged: (data) {
                            controller.districtID.value = data!.id;
                            controller.districtIdForSubDivision.value = data.id;
                            controller.districtIdForBlock.value = data.id;
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<SubDivisionModel>(
                          selectedItem: controller.subDivisionValue.value,
                          validator: (value) {
                            if (value == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Sub Division',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          asyncItems: (String filter) async {
                            var response = await screenServices.getSubDivision(
                                int.parse(controller
                                    .districtIdForSubDivision.value
                                    .toString()));
                            var data = SubDivisionModel.fromJsonList(response);
                            return data;
                          },
                          onChanged: (data) {
                            controller.subDivisionID.value = data!.id;
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<RdBlockModel>(
                          selectedItem: controller.rdBlockValue.value,
                          validator: (value) {
                            if (value == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'RD Block',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          asyncItems: (String filter) async {
                            var response = await basicInfoServices.getRdBlock(
                                controller.districtIdForBlock.value);
                            var data = RdBlockModel.fromJsonList(response);
                            return data;
                          },
                          onChanged: (data) {
                            controller.blockIdForVillage.value = data!.id;
                            controller.rdBlockID.value = data.id;
                            controller.update();
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<VillageModel>(
                          selectedItem: controller.villageValue.value,
                          validator: (value) {
                            if (value == null) {
                              return 'Required field';
                            }
                            return null;
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: reusableWidget.textBoxTextSyle(),
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: reusableWidget.borderStyle(),
                              focusedBorder: reusableWidget.borderStyle(),
                              errorBorder: reusableWidget.errorBorderStyle(),
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Village/Locality',
                              labelStyle: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          asyncItems: (String filter) async {
                            var response = await basicInfoServices
                                .getVillage(controller.blockIdForVillage.value);
                            var data = VillageModel.fromJsonList(response);
                            return data;
                          },
                          onChanged: (data) {
                            controller.villageID.value = data!.id;
                            controller.update();
                          },
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      const Text('Bank Details'),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.bankNameTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Bank Name',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.accountNumberTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Account Number',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.branchNameTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Branch Name',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.ifscTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'IFSC  Code',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                      reusableWidget.textBoxSpace(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
