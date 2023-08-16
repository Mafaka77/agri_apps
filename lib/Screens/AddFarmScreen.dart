import 'dart:io';

import 'package:agri_farmers_app/Controllers/FarmLandControleer.dart';
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/DistrictModel.dart';
import '../Models/RdBlockModel.dart';
import '../Models/SubDivisionModel.dart';
import '../Models/VillageModel.dart';
import '../Services/BasicInfoServices.dart';
import '../Services/HomeScreenServices.dart';

class AddFarmScreen extends StatelessWidget {
  AddFarmScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  FarmLandServices farmLandServices = Get.find(tag: 'farmLandServices');
  HomeScreenServices screenServices = Get.find(tag: 'homeScreenServices');
  BasicInfoServices basicInfoServices = Get.find(tag: 'basicInfoServices');
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FarmLandController>(
        init: FarmLandController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: MyColors.deepGreen,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: controller.centralFarmerIdTextController,
                        decoration: InputDecoration(
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Farmer ID (Provided by Central Govt.)',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: controller.landOwnerNameTextController,
                        decoration: InputDecoration(
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Land Owner Name',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.totalFarmAreaTextController,
                        decoration: InputDecoration(
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Total Farm Area(In Acres)',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    Obx(
                      () => controller.isLoading.isTrue
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller:
                                    controller.latitudeTextController.value,
                                decoration: InputDecoration(
                                  enabledBorder: reusableWidget.borderStyle(),
                                  focusedBorder: reusableWidget.borderStyle(),
                                  label: Text(
                                    'Latitude',
                                    style: reusableWidget.textBoxTextSyle(),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    reusableWidget.textBoxSpace(),
                    Obx(
                      () => SizedBox(
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.longitudeTextController.value,
                          decoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            label: Text(
                              'Longitude',
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    Obx(
                      () => SizedBox(
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.altitudeTextController.value,
                          decoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            label: Text(
                              'Altitude',
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: DropdownSearch<LandHoldingModel>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Land Holding',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response =
                              await farmLandServices.getLandHolding();
                          var data = LandHoldingModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          controller.landHoldingID.value = data!.id;
                        },
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    const Text('Farm Location'),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: DropdownSearch<DistrictModel>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Select District',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var res = await screenServices.getAllDistrict();
                          var data = DistrictModel.fromJsonList(res);
                          return data;
                        },
                        onChanged: (data) {
                          controller.districtId.value = data!.id;
                          controller.districtIdForBlock.value = data.id;
                        },
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: DropdownSearch<SubDivisionModel>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Sub Division',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response = await screenServices.getSubDivision();
                          var data = SubDivisionModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          controller.subDivisionId.value = data!.id;
                        },
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: DropdownSearch<RdBlockModel>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
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
                    ),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: DropdownSearch<VillageModel>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
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
                    ),
                    reusableWidget.textBoxSpace(),
                    const Text('Landholding Documents(LSC/P.Patta/VC PASS)'),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: DropdownSearch<OwnershipTypeModel>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
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
                    ),
                    reusableWidget.textBoxSpace(),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: controller.landholdingNumberTextController,
                        decoration: InputDecoration(
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Document Number(LSC/P.Patta/VC PASS)',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      controller: controller.landholdingFileTextController,
                      onTap: () {
                        _pickImage(ImageSource.camera, controller);
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Upload Document',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                    ),
                    controller.landholdingFile != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.landholdingFile = null;
                                  controller.landholdingFileTextController
                                      .clear();
                                  controller.update();
                                },
                                child: const Text('Remove'),
                              ),
                            ],
                          )
                        : Container(),
                    reusableWidget.textBoxSpace(),
                    const Text('Irrigation & Machinery Details'),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<
                        IrrigationInfrastructureModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
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
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.kharifTotalArea,
                        decoration: InputDecoration(
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Farm Area(Kharif)',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<RabiCropModel>.multiSelection(
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
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
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.rabiTotalArea,
                        decoration: InputDecoration(
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Farm Area(Rabi)',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                      ),
                    ),
                    reusableWidget.textBoxSpace(),
                    reusableWidget.textBoxSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          elevation: 0,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.deepGreen),
                              borderRadius: BorderRadius.circular(20)),
                          minWidth: Get.width * 0.4,
                          onPressed: () {},
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
                            controller.submitFarmDetails(data.ids);
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    reusableWidget.textBoxSpace(),
                    reusableWidget.textBoxSpace(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _pickImage(
      ImageSource source, FarmLandController controller) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    controller.landholdingFile = File(pickedFile!.path);
    controller.landholdingFileTextController.text = pickedFile.name;
    controller.update();
  }
}
