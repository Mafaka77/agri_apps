import 'package:agri_farmers_app/Controllers/LandWaterScreenController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Models/LandCrops.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/LandWaterScreenServices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../../MyColors.dart';

class OnlineAddLandWaterScreen extends StatelessWidget {
  OnlineAddLandWaterScreen({Key? key}) : super(key: key);
  var farmerId = Get.arguments[0];
  ReusableWidget reusableWidget = ReusableWidget();
  LandWaterScreenServices services = Get.find(tag: 'landWaterScreenServices');
  OnlineHomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandWaterScreenController>(
        init: LandWaterScreenController(),
        builder: (controller) {
          return Scaffold(
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
                    return controller.isEdit.isTrue
                        ? MaterialButton(
                            elevation: 0,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            color: MyColors.deepGreen,
                            minWidth: Get.width * 0.4,
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                await controller.updateLandWater(farmerId, () {
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
                                    Navigator.pop(context);
                                  }, () {});
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                      'Error Occured!!',
                                      const Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ));
                                });
                              } else {
                                reusableWidget.rawSnackBar(
                                    'Please fill all required *',
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ));
                              }
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
                              if (controller.formKey.currentState!.validate()) {
                                await controller.submitLandWater(farmerId, () {
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
                                    Navigator.pop(context);
                                  }, () {});
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                      'Error Occured!!',
                                      const Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ));
                                });
                              } else {
                                reusableWidget.rawSnackBar(
                                    'Please fill all required *',
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ));
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
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(children: [
                    const Text(
                        'Land Resource, Soil & Water Conservation Details:'),
                    reusableWidget.twoLine(),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      controller: controller.ownerID,
                      decoration: InputDecoration(
                        isDense: true,
                        errorBorder: reusableWidget.errorBorderStyle(),
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Owner ID',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Required field';
                        }
                        return null;
                      },
                      controller: controller.location,
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
                    DropdownSearch<LandCrops>.multiSelection(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required field';
                        }
                        return null;
                      },
                      selectedItems: controller.cropsGrownData,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        baseStyle: reusableWidget.textBoxTextSyle(),
                        dropdownSearchDecoration: InputDecoration(
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          contentPadding: const EdgeInsets.all(10),
                          errorBorder: reusableWidget.errorBorderStyle(),
                          labelText: 'Crops Grown *',
                          labelStyle: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      asyncItems: (String filter) async {
                        var response = await services.getLandCrops();
                        var data = LandCrops.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        var id = data.map((e) => e.id);
                        controller.cropsGrown.clear();
                        controller.cropsGrown.addAll(id);
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Required field';
                        }
                        return null;
                      },
                      controller: controller.totalArea,
                      decoration: InputDecoration(
                        isDense: true,
                        errorBorder: reusableWidget.errorBorderStyle(),
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Total Area Sown *',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }
}
