import 'dart:io';

import 'package:agri_farmers_app/Controllers/FarmLandControleer.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
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
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Services/BasicInfoServices.dart';
import '../../Services/HomeScreenServices.dart';
import '../../Models/DistrictModel.dart';
import '../../Models/RdBlockModel.dart';
import '../../Models/SubDivisionModel.dart';
import '../../Models/VillageModel.dart';

class OnlineAddFarmScreen extends StatelessWidget {
  OnlineAddFarmScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  FarmLandServices farmLandServices = Get.find(tag: 'farmLandServices');
  HomeScreenServices screenServices = Get.find(tag: 'homeScreenServices');
  BasicInfoServices basicInfoServices = Get.find(tag: 'basicInfoServices');
  OnlineHomeController homeController = Get.find();
  var storage = const FlutterSecureStorage();
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FarmLandController>(
        init: FarmLandController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: MyColors.deepGreen,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
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
                              controller.editAgriFarm(data.id, data.farmers_id,
                                  () {
                                reusableWidget.loader(context);
                              }, () {
                                Loader.hide();
                                reusableWidget.rawSnackBar(
                                  'Successfully Edited',
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
                                controller.submitOnlineAgricultureLand(data.id,
                                    () {
                                  reusableWidget.loader(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Successfully Added',
                                    const Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                  );
                                  homeController
                                      .getFarmerFarmDetails(data.id, () {}, () {
                                    homeController.checkStatus(data.id);
                                    homeController.checkVerification(
                                        data.id, () {}, () {}, () {});
                                    homeController.getAllFarmers('');
                                    Navigator.pop(context);
                                  }, () {});
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Error Occured',
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
                          );
                  })
                ],
              ),
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
                        controller: controller.centralFarmerIdTextController,
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: reusableWidget.errorBorderStyle(),
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
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        controller: controller.landOwnerNameTextController,
                        decoration: reusableWidget
                            .textBoxDecoration('Land Owner Name *'),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: controller.totalFarmAreaTextController,
                        decoration: reusableWidget
                            .textBoxDecoration('Total Farm Area (in Acres) *'),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Required field ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: controller.latitudeTextController.value,
                          decoration:
                              reusableWidget.textBoxDecoration('Altitude'),
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Required field ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: controller.longitudeTextController.value,
                          decoration:
                              reusableWidget.textBoxDecoration('Longitude *'),
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Required field ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: controller.altitudeTextController.value,
                          decoration:
                              reusableWidget.textBoxDecoration('Altitude *'),
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => DropdownSearch<LandHoldingModel>(
                          validator: (value) {
                            if (value == null) {
                              return 'Required field ';
                            }
                            return null;
                          },
                          selectedItem: controller.landHoldingData.value,
                          dropdownDecoratorProps: reusableWidget
                              .dropDownDecoration('Land Holding *'),
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
                      DropdownSearch<DistrictModel>(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        selectedItem: controller.districtValue.value,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Select District *'),
                        asyncItems: (String filter) async {
                          var res = await screenServices.getAllDistrict();
                          var data = DistrictModel.fromJsonList(res);
                          return data;
                        },
                        onChanged: (data) {
                          controller.districtId.value = data!.id;
                          controller.districtIdForBlock.value = data.id;
                          controller.districtIdForSubDivision.value = data.id;
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<SubDivisionModel>(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        selectedItem: controller.subDivisionValue.value,
                        dropdownDecoratorProps:
                            reusableWidget.dropDownDecoration('Sub Division *'),
                        asyncItems: (String filter) async {
                          var response = await screenServices.getSubDivision(
                              controller.districtIdForSubDivision.value);
                          var data = SubDivisionModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          controller.subDivisionId.value = data!.id;
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<RdBlockModel>(
                        validator: (value) {
                          if (value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        selectedItem: controller.blockValue.value,
                        dropdownDecoratorProps:
                            reusableWidget.dropDownDecoration('RD Block *'),
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
                        validator: (value) {
                          if (value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        selectedItem: controller.villageValue.value,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Village/Locality *'),
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
                        validator: (value) {
                          if (value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        selectedItem: controller.ownerTypeValue.value,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Ownership Type *'),
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
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'Required field ';
                          }
                          return null;
                        },
                        controller: controller.landholdingNumberTextController,
                        decoration: reusableWidget.textBoxDecoration(
                            'Document Number(LSC/P.Patta/VC PASS) *'),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      //FILE 1---------------------------------------------------
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Required field ';
                            }
                            return null;
                          },
                          controller: controller.landholdingFileTextController,
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
                                      child:
                                          const Text('Pick from File Manager'),
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
                            focusedErrorBorder:
                                reusableWidget.errorBorderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            label: Text(
                              'Upload Document *',
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     controller.isFile2Visible.isTrue
                      //         ? Container()
                      //         : TextButton(
                      //             onPressed: () {
                      //               controller.isFile2Visible.value = true;
                      //               controller.update();
                      //             },
                      //             child: const Text('Add more')),
                      //   ],
                      // ),
                      reusableWidget.textBoxSpace(),
                      //FILE NO 2
                      // Obx(
                      //   () => Visibility(
                      //     visible: controller.isFile2Visible.value,
                      //     child: TextFormField(
                      //       controller: controller.landholdingFile2TextController,
                      //       onTap: () {
                      //         showCupertinoModalPopup(
                      //           barrierColor: Colors.black87,
                      //           context: context,
                      //           builder: (c) {
                      //             return CupertinoActionSheet(
                      //               actions: [
                      //                 CupertinoActionSheetAction(
                      //                   onPressed: () {
                      //                     picksinglefile2(controller);
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child:
                      //                       const Text('Pick from File Manager'),
                      //                 ),
                      //                 CupertinoActionSheetAction(
                      //                   onPressed: () {
                      //                     _pickImage2(
                      //                         ImageSource.camera, controller);
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child: const Text('Open Camera'),
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //         );
                      //       },
                      //       readOnly: true,
                      //       decoration: InputDecoration(
                      //         suffixIcon: controller.landholdingFile != null
                      //             ? InkWell(
                      //                 onTap: () {
                      //                   controller.landholdingFile2 = null;
                      //                   controller.landholdingFile2TextController
                      //                       .clear();
                      //                   controller.update();
                      //                 },
                      //                 child: const Icon(
                      //                   Icons.clear,
                      //                   color: Colors.red,
                      //                 ),
                      //               )
                      //             : const Icon(Icons.attachment_rounded),
                      //         enabledBorder: reusableWidget.borderStyle(),
                      //         focusedBorder: reusableWidget.borderStyle(),
                      //         label: Text(
                      //           'Upload Document',
                      //           style: reusableWidget.textBoxTextSyle(),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     controller.isFile2Visible.isFalse
                      //         ? Container()
                      //         : TextButton(
                      //             onPressed: () {
                      //               controller.isFile2Visible.value = true;
                      //               controller.update();
                      //             },
                      //             child: const Text('Add more')),
                      //     controller.isFile2Visible.isTrue
                      //         ? TextButton(
                      //             onPressed: () {
                      //               controller.isFile2Visible.value = false;
                      //               controller.landholdingFile2 = null;
                      //               controller.landholdingFile2TextController
                      //                   .clear();
                      //               controller.update();
                      //               controller.update();
                      //             },
                      //             child: const Text('Remove'),
                      //           )
                      //         : Container(),
                      //   ],
                      // ),
                      reusableWidget.textBoxSpace(),
                      const Text('Irrigation & Machinery Details'),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<
                          IrrigationInfrastructureModel>.multiSelection(
                        selectedItems: controller.infrastructureValue,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Irrigation Infrastructure'),
                        asyncItems: (String filter) async {
                          var response = await farmLandServices.getIrrigation();
                          var data = IrrigationInfrastructureModel.fromJsonList(
                              response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.infrastructure.clear();
                          controller.infrastructure.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<FarmEquipmentModel>.multiSelection(
                        selectedItems: controller.equipmentValue,
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Farm Machinery/Equipments'),
                        asyncItems: (String filter) async {
                          var response = await farmLandServices.getEquipment();
                          var data = FarmEquipmentModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.equipment.clear();
                          controller.equipment.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      const Text('Crop Details'),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<KharifCropModel>.multiSelection(
                        selectedItems: controller.kharifCropValue,
                        dropdownDecoratorProps:
                            reusableWidget.dropDownDecoration('Kharif Crops'),
                        asyncItems: (String filter) async {
                          var response =
                              await farmLandServices.getKharifCrops();
                          var data = KharifCropModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.kharifCrop.clear();
                          controller.kharifCrop.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.kharifTotalArea,
                        decoration: reusableWidget
                            .textBoxDecoration('Farm Area(Kharif)'),
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                      reusableWidget.textBoxSpace(),
                      DropdownSearch<RabiCropModel>.multiSelection(
                        selectedItems: controller.rabiCropValue,
                        dropdownDecoratorProps:
                            reusableWidget.dropDownDecoration('Rabi Crops'),
                        asyncItems: (String filter) async {
                          var response = await farmLandServices.getRabiCrops();
                          var data = RabiCropModel.fromJsonList(response);
                          return data;
                        },
                        onChanged: (data) {
                          var id = data.map((e) => e.id);
                          controller.rabiCrop.clear();
                          controller.rabiCrop.addAll(id);
                          controller.update();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.rabiTotalArea,
                        decoration:
                            reusableWidget.textBoxDecoration('Farm Area(Rabi)'),
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
                        dropdownDecoratorProps: reusableWidget
                            .dropDownDecoration('Oil Palm Plantation'),
                        onChanged: (val) {
                          controller.oilPalmPlantation.value = val.toString();
                        },
                      ),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.oilPalmArea,
                        decoration:
                            reusableWidget.textBoxDecoration('Oil Palm Area'),
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
            ),
          );
        });
  }

  Future<void> _pickImage(BuildContext context, ImageSource source,
      FarmLandController controller) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    controller.landholdingFile = File(pickedFile!.path);
    controller.update();
    controller.uploadLandHoldingFile(() {
      reusableWidget.loader(context);
    }, () {
      reusableWidget.rawSnackBar(
        'Document Uploaded Successfully',
        Icon(
          Icons.check,
          color: MyColors.deepGreen,
        ),
      );
      Loader.hide();
    }, () {
      reusableWidget.rawSnackBar(
        'Error Occured!! Try again!',
        const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
      Loader.hide();
    });
  }

  Future<void> picksinglefile(
      BuildContext context, FarmLandController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: true,
    );
    if (result != null) {
      controller.landholdingFile = File(result.files.first.path!);
      controller.update();
      controller.uploadLandHoldingFile(() {
        reusableWidget.loader(context);
      }, () {
        reusableWidget.rawSnackBar(
          'Document Uploaded Successfully',
          Icon(
            Icons.check,
            color: MyColors.deepGreen,
          ),
        );
        Loader.hide();
      }, () {
        reusableWidget.rawSnackBar(
          'Error Occured!! Try again!',
          const Icon(
            Icons.warning,
            color: Colors.red,
          ),
        );
        Loader.hide();
      });
    }
  }

  Future<void> _pickImage2(
      ImageSource source, FarmLandController controller) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    controller.landholdingFile2 = File(pickedFile!.path);
    controller.landholdingFile2TextController.text = pickedFile.path;
    controller.update();
  }

  Future<void> picksinglefile2(FarmLandController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: true,
    );
    if (result != null) {
      controller.landholdingFile2 = File(result.files.first.path!);
      controller.landholdingFile2TextController.text = result.files.first.name;
      controller.update();
    }
  }
}
