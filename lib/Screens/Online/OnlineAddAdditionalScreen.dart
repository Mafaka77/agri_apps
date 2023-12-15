import 'dart:io';

import 'package:agri_farmers_app/Controllers/AdditionalScreenController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Models/SchemeModel.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/AdditionalScreenServices.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

class OnlineAddAdditionalScreen extends StatelessWidget {
  OnlineAddAdditionalScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  AdditionalScreenServices services = Get.find(tag: 'additionalScreenServices');
  OnlineHomeController homeController = Get.find();
  var data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdditionalScreenController>(
        init: AdditionalScreenController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: MyColors.deepGreen,
              elevation: 0,
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
                                await controller.updateAdditionalDetails(
                                    data.id, data.farmers_id, () {
                                  reusableWidget.loader(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Additional Details Updated',
                                    Icon(
                                      Icons.check,
                                      color: MyColors.deepGreen,
                                    ),
                                  );
                                  homeController.getFarmerFarmDetails(
                                      data.farmers_id, () {}, () {
                                    homeController.checkStatus(data.farmers_id);
                                    Navigator.pop(context);
                                  }, () {});
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Error!! Try Again',
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
                                await controller.submitAddtionalDetails(data.id,
                                    () {
                                  reusableWidget.loader(context);
                                }, () {
                                  Loader.hide();
                                  reusableWidget.rawSnackBar(
                                    'Additional Details Added',
                                    Icon(
                                      Icons.check,
                                      color: MyColors.deepGreen,
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
                                    'Error!! Try Again',
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
                  ),
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
                        validator: (value) {
                          if (value == '' || value!.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        controller: controller.rationCardNumberTextController,
                        decoration: reusableWidget
                            .textBoxDecoration('Ration Card Number'),
                        style: const TextStyle(fontSize: 13),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == '' || value!.isEmpty) {
                              return 'Required field';
                            }
                            return null;
                          },
                          controller:
                              controller.rationCardFileNameTextController,
                          onTap: () {
                            showCupertinoModalPopup(
                              barrierColor: Colors.black87,
                              context: context,
                              builder: (c) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickRationCardImage(context,
                                            ImageSource.camera, controller);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Open Camera'),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickRationCardFile(context, controller);
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const Text('Pick from File Manager'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense: true,
                            errorBorder: reusableWidget.errorBorderStyle(),
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            suffixIcon: controller.isRationCardPicked.isTrue
                                ? IconButton(
                                    onPressed: () {
                                      controller.rationCardFile = null;
                                      controller
                                          .rationCardFileNameTextController
                                          .clear();
                                      controller.isRationCardPicked.value =
                                          false;
                                      controller.update();
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ))
                                : const Icon(Icons.attachment_outlined),
                            label: Text(
                              'Upload Ration Card',
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: Get.height * 0.08,
                          maxHeight: Get.height * 0.08,
                        ),
                        child: DropdownSearch<SchemeModel>(
                          dropdownDecoratorProps:
                              reusableWidget.dropDownDecoration('Scheme Name'),
                          asyncItems: (String filter) async {
                            var response = await services.getScheme();
                            var data = SchemeModel.fromJsonList(response);
                            controller.schemes.addAll(data);
                            return data;
                          },
                          onChanged: (data) {
                            controller.schemeId.value = data!.id;
                            controller.schemeName.value = data.toString();
                            controller.update();
                          },
                        ),
                      ),
                      MaterialButton(
                        elevation: 0,
                        color: MyColors.deepGreen,
                        onPressed: () {
                          controller.schemes.isEmpty
                              ? reusableWidget.rawSnackBar(
                                  'Please Select Scheme',
                                  const Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ))
                              : controller.schemeApplied.add({
                                  'scheme_id': controller.schemeId.value,
                                  'scheme_name':
                                      controller.schemeName.toString(),
                                  'availed': controller.availed.value,
                                  'amount': controller.amount.value,
                                });
                          controller.update();
                          print(controller.schemeApplied);
                        },
                        child: const Text(
                          'Add Scheme',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Obx(
                        () => ListView.builder(
                          itemCount: controller.schemeApplied.length,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            var data = controller.schemeApplied[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['scheme_name'],
                                ),
                                SizedBox(
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.07,
                                  child: DropdownSearch<String>(
                                    selectedItem: data['availed'],
                                    validator: (val) {
                                      if (val == null) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                    items: const [
                                      "Yes",
                                      // "No",
                                    ],
                                    dropdownDecoratorProps: reusableWidget
                                        .dropDownDecoration('Availed?'),
                                    onChanged: (val) {
                                      controller.availed.value = val.toString();
                                      controller.update();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  height: Get.height * 0.06,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: data['amount'],
                                    decoration: reusableWidget
                                        .textBoxDecoration('Amount'),
                                    style: const TextStyle(fontSize: 13),
                                    onChanged: (value) {
                                      data['amount'] = value;
                                      controller.update();
                                    },
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.schemeApplied.remove(data);
                                    controller.update();
                                  },
                                  child: const Text('Remove'),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Divider(
                        color: MyColors.deepGreen,
                      ),
                      const Text('Kissan Credit Card'),
                      Obx(
                        () => RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          horizontalAlignment: MainAxisAlignment.start,
                          groupValue: controller.isKCCAvailed.value,
                          onChanged: (value) {
                            controller.isKCCAvailed.value = value.toString();
                            if (value == 'Yes') {
                              // controller.occupationTextController.clear();
                            }
                          },
                          items: const ['Yes', 'No'],
                          itemBuilder: (item) => RadioButtonBuilder(item),
                        ),
                      ),
                      //KISSAN CREDIT CARD IF YES
                      Obx(
                        () => controller.isKCCAvailed == 'Yes'
                            ? Column(
                                children: [
                                  TextFormField(
                                    controller:
                                        controller.kccCardNumberTextController,
                                    decoration: reusableWidget
                                        .textBoxDecoration('KCC Card Number *'),
                                  ),
                                  reusableWidget.textBoxSpace(),
                                  TextFormField(
                                    controller:
                                        controller.kccRenewTextController,
                                    decoration: reusableWidget
                                        .textBoxDecoration('KCC Renew or New'),
                                  ),
                                  reusableWidget.textBoxSpace(),
                                  TextFormField(
                                    controller:
                                        controller.kccBankNameTextController,
                                    decoration: reusableWidget
                                        .textBoxDecoration('Bank Name'),
                                  ),
                                  reusableWidget.textBoxSpace(),
                                  TextFormField(
                                    controller:
                                        controller.kccBranchTextController,
                                    decoration: reusableWidget
                                        .textBoxDecoration('Branch Name'),
                                  ),
                                  reusableWidget.textBoxSpace(),
                                  TextFormField(
                                    controller: controller
                                        .kccYearOfSanctionedTextController,
                                    decoration:
                                        reusableWidget.textBoxDecoration(
                                            'Year of Sanctioned'),
                                  ),
                                  reusableWidget.textBoxSpace(),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller
                                        .kccSanctionedAmountTextController,
                                    decoration:
                                        reusableWidget.textBoxDecoration(
                                            'Sanctioned Amount in (Rs)'),
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                      Divider(
                        color: MyColors.deepGreen,
                      ),
                      const Text('Supporting Documents'),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == '' || value!.isEmpty) {
                              return 'Required field';
                            }
                            return null;
                          },
                          controller: controller.aadhaarCardFileTextController,
                          onTap: () {
                            showCupertinoModalPopup(
                              barrierColor: Colors.black87,
                              context: context,
                              builder: (c) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickAadhaarImage(context,
                                            ImageSource.camera, controller);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Open Camera'),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickAadhaarFile(context, controller);
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const Text('Pick from File Manager'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense: true,
                            errorBorder: reusableWidget.errorBorderStyle(),
                            suffixIcon: controller.isAadhaarCardPicked.isTrue
                                ? IconButton(
                                    onPressed: () {
                                      controller.aadhaarCardFile = null;
                                      controller.aadhaarCardFileTextController
                                          .clear();
                                      controller.update();
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ))
                                : Icon(
                                    Icons.attachment_outlined,
                                    color: MyColors.deepGreen,
                                  ),
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            label: Text(
                              'Upload Aadhaar Card',
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      reusableWidget.textBoxSpace(),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == '' || value!.isEmpty) {
                              return 'Required field';
                            }
                            return null;
                          },
                          controller: controller.bankPassbookFileTextController,
                          onTap: () {
                            showCupertinoModalPopup(
                              barrierColor: Colors.black87,
                              context: context,
                              builder: (c) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickPassbookImage(context,
                                            ImageSource.camera, controller);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Open Camera'),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickPassbookFile(context, controller);
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const Text('Pick from File Manager'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense: true,
                            errorBorder: reusableWidget.errorBorderStyle(),
                            suffixIcon: controller.isBankPassbookPicked.isTrue
                                ? IconButton(
                                    onPressed: () {
                                      controller.bankPassbookFile = null;
                                      controller.bankPassbookFileTextController
                                          .clear();
                                      controller.update();
                                    },
                                    icon: const Icon(Icons.clear))
                                : Icon(
                                    Icons.attachment_outlined,
                                    color: MyColors.deepGreen,
                                  ),
                            enabledBorder: reusableWidget.borderStyle(),
                            focusedBorder: reusableWidget.borderStyle(),
                            label: Text(
                              'Upload Bank Passbook(Front)',
                              style: reusableWidget.textBoxTextSyle(),
                            ),
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      Divider(
                        color: MyColors.deepGreen,
                      ),
                      const Text('Enumerator Details'),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                          validator: (val) =>
                              val != '' ? null : 'Required field *',
                          onTap: () {
                            controller.pickDOB(context);
                          },
                          controller: controller.dateTextController,
                          readOnly: true,
                          decoration: reusableWidget
                              .textBoxDecoration('Date of Data Collection')),
                      reusableWidget.textBoxSpace(),
                      TextFormField(
                        maxLines: 4,
                        decoration: reusableWidget.textBoxDecoration('Remarks'),
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

  Future<void> pickAadhaarImage(BuildContext context, ImageSource source,
      AdditionalScreenController controller) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    controller.aadhaarCardFile = File(pickedFile!.path);
    controller.update();
    controller.uploadAadhaarCardFile(() {
      reusableWidget.loader(context);
    }, () {
      reusableWidget.rawSnackBar(
          'Aadhaar Card Uploaded',
          const Icon(
            Icons.check,
            color: Colors.blue,
          ));
      Loader.hide();
    }, () {
      Loader.hide();
      reusableWidget.rawSnackBar(
        'Upload Failed..File type should be pdf or doc',
        const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    });
  }

  Future<void> pickAadhaarFile(
      BuildContext context, AdditionalScreenController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc']);
    if (result != null) {
      controller.aadhaarCardFile = File(result.files.first.path!);
      controller.update();
      controller.uploadAadhaarCardFile(() {
        reusableWidget.loader(context);
      }, () {
        reusableWidget.rawSnackBar(
            'Aadhaar Card Uploaded',
            const Icon(
              Icons.check,
              color: Colors.blue,
            ));
        Loader.hide();
      }, () {
        Loader.hide();
        reusableWidget.rawSnackBar(
          'Upload Failed..File type should be pdf or doc',
          const Icon(
            Icons.warning,
            color: Colors.red,
          ),
        );
      });
    }
  }

  Future<void> pickRationCardImage(BuildContext context, ImageSource source,
      AdditionalScreenController controller) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    controller.rationCardFile = File(pickedFile!.path);
    controller.update();
    controller.uploadRationCardFile(() {
      reusableWidget.loader(context);
    }, () {
      reusableWidget.rawSnackBar(
          'Ration Card Uploaded',
          const Icon(
            Icons.check,
            color: Colors.blue,
          ));
      Loader.hide();
    }, () {
      Loader.hide();
      reusableWidget.rawSnackBar(
        'Upload Failed..File type should be pdf or doc',
        const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    });
  }

  Future<void> pickRationCardFile(
      BuildContext context, AdditionalScreenController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowedExtensions: ['pdf', 'doc'],
      type: FileType.custom,
    );
    if (result != null) {
      controller.rationCardFile = File(result.files.first.path!);
      // controller.rationCardFileNameTextController.text =
      //     result.files.first.name;
      controller.update();
      await controller.uploadRationCardFile(() {
        reusableWidget.loader(context);
      }, () {
        reusableWidget.rawSnackBar(
            'Ration Card Uploaded',
            const Icon(
              Icons.check,
              color: Colors.blue,
            ));
        Loader.hide();
      }, () {
        Loader.hide();
        reusableWidget.rawSnackBar(
          'Upload Failed..Try again!!',
          const Icon(
            Icons.warning,
            color: Colors.red,
          ),
        );
      });
    }
  }

  Future<void> pickPassbookImage(BuildContext context, ImageSource source,
      AdditionalScreenController controller) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
      preferredCameraDevice: CameraDevice.rear,
      requestFullMetadata: true,
    );
    controller.bankPassbookFile = File(pickedFile!.path);
    controller.update();
    controller.uploadBankPassbookFile(() {
      reusableWidget.loader(context);
    }, () {
      reusableWidget.rawSnackBar(
          'Aadhaar Card Uploaded',
          const Icon(
            Icons.check,
            color: Colors.blue,
          ));
      Loader.hide();
    }, () {
      Loader.hide();
      reusableWidget.rawSnackBar(
        'Upload Failed..File type should be pdf or doc',
        const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    });
  }

  Future<void> pickPassbookFile(
      BuildContext context, AdditionalScreenController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: true,
    );
    if (result != null) {
      controller.bankPassbookFile = File(result.files.first.path!);
      controller.update();
      controller.uploadAadhaarCardFile(() {
        reusableWidget.loader(context);
      }, () {
        reusableWidget.rawSnackBar(
            'Aadhaar Card Uploaded',
            const Icon(
              Icons.check,
              color: Colors.blue,
            ));
        Loader.hide();
      }, () {
        Loader.hide();
        reusableWidget.rawSnackBar(
          'Upload Failed..File type should be pdf or doc',
          const Icon(
            Icons.warning,
            color: Colors.red,
          ),
        );
      });
    }
  }
}
