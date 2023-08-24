import 'dart:io';

import 'package:agri_farmers_app/Controllers/ResourceScreenController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ResourceScreen extends StatelessWidget {
  ResourceScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResourceScreenController>(
        init: ResourceScreenController(),
        builder: (controller) {
          return Scaffold(body: Obx(() {
            return controller.isDownloading.isTrue
                ? Center(
                    child: Platform.isIOS
                        ? const CupertinoActivityIndicator(
                            color: Colors.black,
                            animating: true,
                          )
                        : const CircularProgressIndicator(
                            color: Colors.black,
                          ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          Text(
                            'We need some access!',
                            style: reusableWidget.textHeadingStyle(),
                          ),
                          reusableWidget.textBoxSpace(),
                          const Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 20),
                            child: Text(
                              'You need to grand access to the device camera, microphone, Photo Library and Location to take photos or record video',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                              ),
                              title: const Text('Camera Access'),
                              trailing: Obx(() {
                                return CupertinoSwitch(
                                  value: controller.cameraPermission.value,
                                  onChanged: (val) async {
                                    if (val == true) {
                                      var permission =
                                          await Permission.camera.status;
                                      controller.cameraPermission.value = val;
                                      if (!permission.isGranted) {
                                        await Permission.camera.request();
                                      }
                                    }
                                  },
                                );
                              })),
                          reusableWidget.textBoxSpace(),
                          ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                              ),
                              title: const Text('Microphone Access'),
                              trailing: Obx(() {
                                return CupertinoSwitch(
                                  value: controller.microphonePermission.value,
                                  onChanged: (val) async {
                                    if (val == true) {
                                      var permission =
                                          await Permission.microphone.status;
                                      controller.microphonePermission.value =
                                          val;
                                      if (!permission.isGranted) {
                                        await Permission.microphone.request();
                                      }
                                    }
                                  },
                                );
                              })),
                          reusableWidget.textBoxSpace(),
                          ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                              ),
                              title: const Text('Photo Library Access'),
                              trailing: Obx(() {
                                return CupertinoSwitch(
                                  value: controller.memoryPermission.value,
                                  onChanged: (val) async {
                                    if (val == true) {
                                      var permission =
                                          await Permission.storage.status;
                                      controller.memoryPermission.value = val;
                                      if (!permission.isGranted) {
                                        await Permission.storage.request();
                                      }
                                    }
                                  },
                                );
                              })),
                          reusableWidget.textBoxSpace(),
                          ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                              ),
                              title: const Text('Location Access'),
                              trailing: Obx(() {
                                return CupertinoSwitch(
                                  value: controller.locationPermission.value,
                                  onChanged: (val) async {
                                    if (val == true) {
                                      var permission =
                                          await Permission.location.status;
                                      controller.locationPermission.value = val;
                                      if (!permission.isGranted) {
                                        await Permission.location.request();
                                      }
                                    }
                                  },
                                );
                              })),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          reusableWidget.textBoxSpace(),
                          MaterialButton(
                            elevation: 0,
                            minWidth: Get.width,
                            height: Get.height * 0.05,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: MyColors.deepGreen,
                            onPressed: () {
                              Get.offAll(() => LoginScreen());
                            },
                            child: const Text(
                              'Lets Get Started',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }));
        });
  }
}
