import 'package:agri_farmers_app/Controllers/HorticultureScreenController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Models/GreenHouseModel.dart';
import 'package:agri_farmers_app/Models/OrchardModel.dart';
import 'package:agri_farmers_app/Models/PlantationModel.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/HorticultureScreenServices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../../Models/KharifCropModel.dart';
import '../../Models/RabiCropModel.dart';

class OnlineAddHorticultureScreen extends StatelessWidget {
  OnlineAddHorticultureScreen({Key? key}) : super(key: key);
  var farmerId = Get.arguments[0];
  ReusableWidget reusableWidget = ReusableWidget();
  HorticultureScreenServices services = Get.find(tag: 'horticultureServices');
  OnlineHomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HorticultureScreenController>(
        init: HorticultureScreenController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: MyColors.deepGreen,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.hortiFarmerIdTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Farmer Horticulture ID',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.locationTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Location *',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                      reusableWidget.textBoxSpace(),
                      const Text(
                        'Crop Details',
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<KharifCropModel>.multiSelection(
                        selectedItems: controller.kharifCropsData,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Kharif Crops',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response = await services.getKharifCrops();
                          var data = KharifCropModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.kharifCrops.clear();
                          controller.kharifCrops.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.kharifTotalAreaTextController,
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
                        selectedItems: controller.rabiCropsData,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Rabi Crops',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response = await services.getRabiCrops();
                          var data = RabiCropModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.rabiCrops.clear();
                          controller.rabiCrops.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.rabiTotalAreaTextController,
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

                      //ORCHARDS AND PLANTATION
                      const Text('Orchards and Plantation Details'),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<OrchardModel>.multiSelection(
                        selectedItems: controller.orchardsData,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Orchards',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response = await services.getOrchards();
                          var data = OrchardModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.orchards.clear();
                          controller.orchards.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<PlantationModel>.multiSelection(
                        selectedItems: controller.plantationData,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Plantation',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response = await services.getPlantation();
                          var data = PlantationModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.plantation.clear();
                          controller.plantation.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      const Text('Greenhouse/Protected Cultivation'),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<GreenHouseModel>.multiSelection(
                        selectedItems: controller.greenHouseData,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Plants Grown',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response = await services.getGreenHousePlant();
                          var data = GreenHouseModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.greenHouse.clear();
                          controller.greenHouse.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller:
                            controller.greenHouseTotalAreaTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Total Greenhouse Area',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            elevation: 0,
                            shape: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.deepGreen),
                                borderRadius: BorderRadius.circular(20)),
                            minWidth: Get.width * 0.4,
                            onPressed: () {
                              print(controller.greenHouse);
                              // Get.back();
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(color: MyColors.deepGreen),
                            ),
                          ),
                          Obx(() => controller.isEdit.isTrue
                              ? MaterialButton(
                                  elevation: 0,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none),
                                  color: MyColors.deepGreen,
                                  minWidth: Get.width * 0.4,
                                  onPressed: () async {
                                    controller.updateHortiDetails(farmerId, () {
                                      reusableWidget.loader(context);
                                    }, () {
                                      Loader.hide();

                                      reusableWidget.rawSnackBar(
                                          'Successfully Updated',
                                          const Icon(
                                            Icons.check,
                                            color: Colors.blue,
                                          ));
                                      homeController.getFarmerFarmDetails(
                                          farmerId, () {}, () {
                                        homeController.checkStatus(farmerId);
                                        Navigator.pop(context);
                                      }, () {});
                                    }, () {
                                      Loader.hide();
                                      reusableWidget.rawSnackBar(
                                          'Error Occured',
                                          const Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                          ));
                                    });
                                  },
                                  child: const Text(
                                    'Edit',
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
                                    controller.submitHortiDetails(farmerId, () {
                                      reusableWidget.loader(context);
                                    }, () {
                                      Loader.hide();
                                      reusableWidget.rawSnackBar(
                                          'Successfully Added',
                                          const Icon(
                                            Icons.check,
                                            color: Colors.blue,
                                          ));
                                      homeController.getFarmerFarmDetails(
                                          farmerId, () {}, () {
                                        homeController.checkStatus(farmerId);
                                        Navigator.pop(context);
                                      }, () {});
                                    }, () {
                                      Loader.hide();
                                      reusableWidget.rawSnackBar(
                                          'Error Occured',
                                          const Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                          ));
                                    });
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
