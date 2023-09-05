import 'package:agri_farmers_app/Controllers/FIsheriesScreenController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Models/FishModel.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../../Services/FisheriesScreenServices.dart';

class OnlineAddFisherieScreen extends StatelessWidget {
  OnlineAddFisherieScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  FisheriesScreenServices services = Get.find(tag: 'fisherieScreenServices');
  OnlineHomeController homeController = Get.find();
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FisheriesScreenController>(
        init: FisheriesScreenController(),
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
                                await controller.updateFisheries(
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
                                await controller.submitFisheries(data.id, () {
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
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.fisherID,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Fisheries ID',
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
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.nurseryPondText,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Nursery Pond',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.nuseryPond.value = 0;
                            controller.update();
                          }
                          controller.nuseryPond.value = int.parse(value);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.rearingPondText,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Rearing Pond',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.rearingPond.value = 0;
                            controller.rearingPond.value = int.parse(value);
                          }
                          controller.rearingPond.value = int.parse(value);
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.grewOutPondText,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
                          enabledBorder: reusableWidget.borderStyle(),
                          focusedBorder: reusableWidget.borderStyle(),
                          label: Text(
                            'Grew Out Pond',
                            style: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.grewOutPond.value = 0;
                            controller.update();
                          }
                          controller.grewOutPond.value = int.parse(value);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      Row(
                        children: [
                          const Text(
                            'Total No of Pond:    ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Obx(() => Text(
                              "${controller.nuseryPond.value + controller.rearingPond.value + controller.grewOutPond.value}")),
                        ],
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
                        controller: controller.totalAreaSown,
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
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<FishModel>.multiSelection(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        selectedItems: controller.fishCulturedData,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Type of fish Cultured *',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        asyncItems: (String filter) async {
                          var response = await services.getFish();
                          var data = FishModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.fishCulturedList.clear();
                          controller.fishCulturedList.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<String>(
                        selectedItem: controller.fishHatchery.value,
                        validator: (val) {
                          if (val == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        items: const [
                          "Cemented",
                          "FRP Hatchery",
                        ],
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: reusableWidget.textBoxTextSyle(),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            contentPadding: const EdgeInsets.all(10),
                            errorBorder: reusableWidget.errorBorderStyle(),
                            labelText: 'Fish Hatchery',
                            labelStyle: reusableWidget.textBoxTextSyle(),
                          ),
                        ),
                        onChanged: (val) {
                          controller.fishHatchery.value = val.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
