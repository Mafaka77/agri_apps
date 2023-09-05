import 'dart:io';

import 'package:agri_farmers_app/Controllers/Offline/OfflineFarmController.dart';
import 'package:agri_farmers_app/Models/FarmEquipmentModel.dart';
import 'package:agri_farmers_app/Models/IrrigationInfrastructure.dart';
import 'package:agri_farmers_app/Models/KharifCropModel.dart';
import 'package:agri_farmers_app/Models/LandHoldingModel.dart';
import 'package:agri_farmers_app/Models/OwnershipTypeModel.dart';
import 'package:agri_farmers_app/Models/RabiCropModel.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/FarmLandServices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Models/DistrictModel.dart';
import '../../Models/RdBlockModel.dart';
import '../../Models/SubDivisionModel.dart';
import '../../Models/VillageModel.dart';
import '../../Services/BasicInfoServices.dart';
import '../../Services/HomeScreenServices.dart';

class OfflineAddFarmScreen extends StatelessWidget {
  OfflineAddFarmScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  FarmLandServices farmLandServices = Get.find(tag: 'farmLandServices');
  HomeScreenServices screenServices = Get.find(tag: 'homeScreenServices');
  BasicInfoServices basicInfoServices = Get.find(tag: 'basicInfoServices');
  var storage = const FlutterSecureStorage();
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfflineFarmController>(
        init: OfflineFarmController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: MyColors.deepGreen,
            ),
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
                  MaterialButton(
                    elevation: 0,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    color: MyColors.deepGreen,
                    minWidth: Get.width * 0.4,
                    onPressed: () async {
                      controller.submitFarmLand(data.id);
                      // if (controller.formKey.currentState!.validate()) {
                      //   controller.submitOnlineAgricultureLand(data.id, () {
                      //     reusableWidget.loader(context);
                      //   }, () {
                      //     Loader.hide();
                      //     reusableWidget.rawSnackBar(
                      //       'Successfully Added',
                      //       const Icon(
                      //         Icons.check,
                      //         color: Colors.blue,
                      //       ),
                      //     );
                      //     homeController.getFarmerFarmDetails(data.id, () {}, () {
                      //       homeController.checkStatus(data.id);
                      //       homeController.checkVerification(
                      //           data.id, () {}, () {}, () {});
                      //       homeController.getAllFarmers('');
                      //       Navigator.pop(context);
                      //     }, () {});
                      //   }, () {
                      //     Loader.hide();
                      //     reusableWidget.rawSnackBar(
                      //       'Error Occured',
                      //       const Icon(
                      //         Icons.warning,
                      //         color: Colors.red,
                      //       ),
                      //     );
                      //   });
                      // }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.centralFarmerId,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Farmer ID (Provided by Central Govt.)',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: reusableWidget.textBoxTextSyle(),
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      controller: controller.landOwnerName,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Land Owner Name',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: reusableWidget.textBoxTextSyle(),
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.totalFarmArea,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Total Farm Area(In Acres)',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: reusableWidget.textBoxTextSyle(),
                    ),
                    reusableWidget.textBoxSpace(),
                    Obx(
                      () => controller.isLoading.isTrue
                          ? const CircularProgressIndicator()
                          : TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller.latitude.value,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: reusableWidget.borderStyle(),
                                focusedBorder: reusableWidget.borderStyle(),
                                label: Text(
                                  'Latitude',
                                  style: reusableWidget.textBoxTextSyle(),
                                ),
                              ),
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                    ),
                    reusableWidget.textBoxSpace(),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.longitude.value,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Longitude',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.altitude.value,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Altitude',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<LandHoldingModel>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Land Holding',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await farmLandServices.getLandHolding();
                        var data = LandHoldingModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        controller.landHoldingId.value = data!.id;
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    const Text('Farm Location'),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<DistrictModel>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Select District',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var districtID = await storage.read(key: 'district_id');
                        var res = await screenServices.getAllDistrict();
                        var data = DistrictModel.fromJsonList(res);
                        return data;
                      },
                      onChanged: (data) {
                        controller.districtId.value = data!.id;
                        controller.districtIdForBlock.value = data.id;
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<SubDivisionModel>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Sub Division',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await screenServices.getSubDivision(1);
                        var data = SubDivisionModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        controller.subDivisionId.value = data!.id;
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<RdBlockModel>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'RD Block',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await basicInfoServices
                            .getRdBlock(controller.districtIdForBlock.value);
                        var data = RdBlockModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        controller.blockIdForVillage.value = data!.id;
                        controller.rdBlockId.value = data.id;
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<VillageModel>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
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
                        controller.villageId.value = data!.id;
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    const Text('Landholding Documents(LSC/P.Patta/VC PASS)'),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<OwnershipTypeModel>(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Ownership Type',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response =
                            await farmLandServices.getOwnershipType();
                        var data = OwnershipTypeModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        controller.ownershipTypeId.value = data!.id;
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      controller: controller.landHoldingNumber,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Document Number(LSC/P.Patta/VC PASS)',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: reusableWidget.textBoxTextSyle(),
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      controller: controller.landHoldingNumber,
                      onTap: () {
                        showCupertinoModalPopup(
                          barrierColor: Colors.black87,
                          context: context,
                          builder: (c) {
                            return CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    picksinglefile(context, controller);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Pick from File Manager'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    _pickImage(context, ImageSource.camera,
                                        controller);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Open Camera'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: controller.isFilePicked.isTrue
                            ? InkWell(
                                onTap: () {
                                  controller.landholdingFile = null;
                                  controller.landholdingFileTextController
                                      .clear();
                                  controller.isFilePicked.value = false;
                                  controller.update();
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                              )
                            : const Icon(Icons.attachment_rounded),
                        isDense: true,
                        errorBorder: reusableWidget.errorBorderStyle(),
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Upload Document',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: reusableWidget.textBoxTextSyle(),
                    ),
                    reusableWidget.textBoxSpace(),
                    const Text('Irrigation & Machinery Details'),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<
                        IrrigationInfrastructureModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Irrigation Infrastructure',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await farmLandServices.getIrrigation();
                        var data = IrrigationInfrastructureModel.fromJsonList(
                            response);
                        return data;
                      },
                      onChanged: (data) {
                        var id = data.map((e) => e.id);
                        controller.infrastructure.clear();
                        controller.infrastructure.add(id);
                        controller.update();
                        print(controller.infrastructure);
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<FarmEquipmentModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Farm Machinery/Equipments',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await farmLandServices.getEquipment();
                        var data = FarmEquipmentModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        var id = data.map((e) => e.id);
                        controller.equipment.clear();
                        controller.equipment.add(id);
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    const Text('Crop Details'),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<KharifCropModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Kharif Crops',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await farmLandServices.getKharifCrops();
                        var data = KharifCropModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        var id = data.map((e) => e.id);
                        controller.kharifCrop.clear();
                        controller.kharifCrop.add(id);
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.kharifTotalArea,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Farm Area(Kharif)',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: reusableWidget.textBoxTextSyle(),
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<RabiCropModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Rabi Crops',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await farmLandServices.getRabiCrops();
                        var data = RabiCropModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        var id = data.map((e) => e.id);
                        controller.rabiCrop.clear();
                        controller.rabiCrop.add(id);
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.rabiTotalArea,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Farm Area(Rabi)',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: reusableWidget.textBoxTextSyle(),
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<String>(
                      selectedItem: controller.oilPalmPlantation.value,
                      validator: (val) {
                        if (val == null) {
                          return 'Required field';
                        }
                        return null;
                      },
                      items: const [
                        "Yes",
                        "No",
                      ],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        baseStyle: reusableWidget.textBoxTextSyle(),
                        dropdownSearchDecoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          labelText: 'Oil Palm Plantation',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      onChanged: (val) {
                        controller.oilPalmPlantation.value = val.toString();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.oilPalmArea,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Oil Palm Area',
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
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _pickImage(BuildContext context, ImageSource source,
      OfflineFarmController controller) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    controller.landholdingFile = File(pickedFile!.path);
    controller.update();
    // controller.uploadLandHoldingFile(() {
    //   reusableWidget.loader(context);
    // }, () {
    //   reusableWidget.rawSnackBar(
    //     'Document Uploaded Successfully',
    //     Icon(
    //       Icons.check,
    //       color: MyColors.deepGreen,
    //     ),
    //   );
    //   Loader.hide();
    // }, () {
    //   reusableWidget.rawSnackBar(
    //     'Error Occured!! Try again!',
    //     const Icon(
    //       Icons.warning,
    //       color: Colors.red,
    //     ),
    //   );
    //   Loader.hide();
    // });
  }

  Future<void> picksinglefile(
      BuildContext context, OfflineFarmController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: true,
    );
    // if (result != null) {
    //   controller.landholdingFile = File(result.files.first.path!);
    //   controller.update();
    //   controller.uploadLandHoldingFile(() {
    //     reusableWidget.loader(context);
    //   }, () {
    //     reusableWidget.rawSnackBar(
    //       'Document Uploaded Successfully',
    //       Icon(
    //         Icons.check,
    //         color: MyColors.deepGreen,
    //       ),
    //     );
    //     Loader.hide();
    //   }, () {
    //     reusableWidget.rawSnackBar(
    //       'Error Occured!! Try again!',
    //       const Icon(
    //         Icons.warning,
    //         color: Colors.red,
    //       ),
    //     );
    //     Loader.hide();
    //   });
    // }
  }
}
