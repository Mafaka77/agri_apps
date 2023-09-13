import 'package:agri_farmers_app/Controllers/AnimalHusbandryController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Models/LivestockModel.dart';
import 'package:agri_farmers_app/Models/TypeOfBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfFarmModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryBreedModel.dart';
import 'package:agri_farmers_app/Models/TypeOfPoultryFarmModel.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/AnimalHusbandryServices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../../MyColors.dart';

class OnlineAnimalHusbandryScreen extends StatelessWidget {
  OnlineAnimalHusbandryScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  var data = Get.arguments[0];
  AnimalHusbandryServices services = Get.find(tag: 'animalHusbandryServices');
  OnlineHomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimalHusbandryController>(
        init: AnimalHusbandryController(),
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
                                controller.updateAnimalHusbandry(
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
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.submitHusbandry(data.id, () {
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.husbandryId,
                        decoration:
                            reusableWidget.textBoxDecoration('Husbandry ID'),
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
                        controller: controller.locationText,
                        decoration:
                            reusableWidget.textBoxDecoration('Location *'),
                        style: const TextStyle(fontSize: 13),
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<LivestockModel>.multiSelection(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        selectedItems: controller.livestockData,
                        dropdownDecoratorProps:
                            reusableWidget.dropDownDecoration('Livestocks *'),
                        asyncItems: (String filter) async {
                          var response = await services.getLiveStock();
                          var data = LivestockModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.livestockList.clear();
                          controller.livestockList.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<TypeOfFarmModel>.multiSelection(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        selectedItems: controller.typeOfFarmData,
                        dropdownDecoratorProps:
                            reusableWidget.dropDownDecoration('Type of Farm *'),
                        asyncItems: (String filter) async {
                          var response = await services.getTypeOfFarm();
                          var data = TypeOfFarmModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.typeOfFarmList.clear();
                          controller.typeOfFarmList.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<TypeOfBreedModel>.multiSelection(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        selectedItems: controller.typeOfBreedData,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Type of Breed *'),
                        asyncItems: (String filter) async {
                          var response = await services.getTypeOfBreed();
                          var data = TypeOfBreedModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.typeOfBreedList.clear();
                          controller.typeOfBreedList.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.adultMaleText,
                        decoration:
                            reusableWidget.textBoxDecoration('Adult Male'),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.adultMale.value = 0;
                          }
                          controller.adultMaleText.text = value;
                          controller.adultMale.value = int.parse(value);
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.adultFemaleText,
                        decoration: reusableWidget.textBoxDecoration('label'),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.adultFemale.value = 0;
                          }
                          controller.adultFemaleText.text = value;
                          controller.adultFemale.value = int.parse(value);
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        controller: controller.youngStockText,
                        keyboardType: TextInputType.number,
                        decoration:
                            reusableWidget.textBoxDecoration('Youngstock'),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.youngStock.value = 0;
                          }
                          controller.youngStockText.text = value;
                          controller.youngStock.value = int.parse(value);
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => Row(
                          children: [
                            const Text('Total:   '),
                            Text(
                                "${controller.adultMale.value + controller.adultFemale.value + controller.youngStock.value}")
                          ],
                        ),
                      ),
                      const Divider(),
                      const Text('Poultry Details'),
                      reusableWidget.twoLine(),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<TypeOfPoultryFarmModel>.multiSelection(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        selectedItems: controller.typeOfPoultryFarmData,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Type of Poultry Farm *'),
                        asyncItems: (String filter) async {
                          var response = await services.getTypeOfPoultryFarm();
                          var data =
                              TypeOfPoultryFarmModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.typeOfPoultryFarmList.clear();
                          controller.typeOfPoultryFarmList.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<TypeOfPoultryBreedModel>.multiSelection(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field';
                          }
                          return null;
                        },
                        selectedItems: controller.typeOfPoultryBreedData,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Type of Poultry Breeds *'),
                        asyncItems: (String filter) async {
                          var response = await services.getTypeOfPoultryBreed();
                          var data =
                              TypeOfPoultryBreedModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.typeOfPoultryBreedList.clear();
                          controller.typeOfPoultryBreedList.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.noOfPoultryText,
                        decoration:
                            reusableWidget.textBoxDecoration('No of Poultry'),
                        style: const TextStyle(fontSize: 13),
                      ),
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
