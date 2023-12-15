import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/ProfileScreenServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreenController extends GetxController {
  ProfileScreenServices services = Get.find(tag: 'profileScreenServices');
  var unsubmitted = 0.obs;
  var submitted = 0.obs;
  var approved = 0.obs;
  var user = {}.obs;
  var isLoading = false.obs;
  var isDownloadButton = false.obs;
  var isPermissionButton = false.obs;
  //PERMISSION
  var cameraPermission = false.obs;
  var microphonePermission = false.obs;
  var memoryPermission = false.obs;
  var locationPermission = false.obs;
  @override
  void onInit() {
    getProfile();
    checkPermission();
    super.onInit();
  }

  checkPermission() async {
    var camera = await Permission.camera.status;
    var microphone = await Permission.microphone.status;
    var storage = await Permission.storage.status;
    var location = await Permission.location.status;
    if (camera.isGranted) {
      cameraPermission.value = true;
    } else {
      cameraPermission.value = false;
    }
    if (microphone.isGranted) {
      microphonePermission.value = true;
    } else {
      microphonePermission.value = false;
    }
    if (storage.isGranted) {
      memoryPermission.value = true;
    } else {
      memoryPermission.value = false;
    }
    if (location.isGranted) {
      locationPermission.value = true;
    } else {
      locationPermission.value = false;
    }
  }

  getProfile() async {
    isLoading.value = true;
    try {
      var storage = const FlutterSecureStorage();
      var id = await storage.read(key: 'userId');
      var data = await services.getProfile(int.parse(id.toString()));
      user.clear();
      user.addAll(data['user']);
      unsubmitted.value = data['unsubmitted'];
      submitted.value = data['submitted'];
      approved.value = data['approved'];
      isDownloadButton.value =
          data['downloadBtn']['download_button'] == 0 ? false : true;
      isPermissionButton.value =
          data['downloadBtn']['permission_button'] == 0 ? false : true;
      isLoading.value = false;
    } catch (ex) {
      print(ex);
      isLoading.value = false;
      ReusableWidget().rawSnackBar(
        'Error Occured',
        const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    }
  }
}
