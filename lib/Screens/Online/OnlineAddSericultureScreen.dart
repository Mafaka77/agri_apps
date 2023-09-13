import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Controllers/SericultureScreenController.dart';
import 'package:agri_farmers_app/Models/SilkwormModel.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/SericultureScreenServices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../../MyColors.dart';

class OnlineAddSericultureScreen extends StatelessWidget {
  OnlineAddSericultureScreen({Key? key}) : super(key: key);
  var data = Get.arguments[0];
  ReusableWidget reusableWidget = ReusableWidget();
  SericultureScreenServices services =
      Get.find(tag: 'sericultureScreenServices');
  OnlineHomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SericultureScreenController>(
        init: SericultureScreenController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                  Obx(
                    () => controller.isEdit.isTrue
                        ? MaterialButton(
                            elevation: 0,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            color: MyColors.deepGreen,
                            minWidth: Get.width * 0.4,
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.updateSericulture(
                                    data.id, data.farmers_id, () {
                                  reusableWidget.loader(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Successfully Updated',
                                    const Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                  );
                                  homeController.getFarmerFarmDetails(
                                      data.farmers_id, () {}, () {
                                    Navigator.pop(context);
                                  }, () {});
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Error Occured!!',
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ),
                                  );
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
                                controller.submitSericulture(data.id, () {
                                  reusableWidget.loader(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Successfully added',
                                    const Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                  );
                                  homeController
                                      .getFarmerFarmDetails(data.id, () {}, () {
                                    Navigator.pop(context);
                                  }, () {});
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Error Occured!!',
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ),
                                  );
                                });
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  )
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
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.sericultureId,
                      decoration:
                          reusableWidget.textBoxDecoration('Sericulture ID'),
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
                      controller: controller.location,
                      decoration:
                          reusableWidget.textBoxDecoration('Location *'),
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
                      keyboardType: TextInputType.number,
                      controller: controller.totalArea,
                      decoration: reusableWidget
                          .textBoxDecoration('Total Farm Area * '),
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
                      keyboardType: TextInputType.number,
                      controller: controller.sizeOfRearingUnit,
                      decoration: reusableWidget.textBoxDecoration(
                          'Size of rearing unit (in sqft) *'),
                      style: const TextStyle(fontSize: 13),
                    ),
                    reusableWidget.textBoxSpace(),
                    DropdownSearch<SilkwormModel>.multiSelection(
                      validator: (value) {
                        if (value == null) {
                          return 'Required field';
                        }
                        return null;
                      },
                      selectedItems: controller.silkwormRearedData,
                      dropdownDecoratorProps: reusableWidget
                          .dropDownDecoration('Silkworm Reared *'),
                      asyncItems: (String filter) async {
                        var response = await services.getAllSilkworm();
                        var data = SilkwormModel.fromJsonList(response);
                        return data;
                      },
                      onChanged: (data) {
                        var id = data.map((e) => e.id);
                        controller.silkwormRearedList.clear();
                        controller.silkwormRearedList.addAll(id);
                        controller.update();
                      },
                    ),
                    reusableWidget.textBoxSpace(),
                    TextFormField(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Required field';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: controller.plantationTotalArea,
                      decoration: reusableWidget.textBoxDecoration(
                          'Area of Silkworm feed plantation *'),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
