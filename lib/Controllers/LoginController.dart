import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/HomeScreen.dart';
import 'package:agri_farmers_app/Screens/ResourceScreen.dart';
import 'package:agri_farmers_app/Services/LoginServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginController extends GetxController {
  LoginServices loginServices = Get.find(tag: 'loginServices');
  ReusableWidget reusableWidget = ReusableWidget();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  var passwordHide = true.obs;

  void login(Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var storage = const FlutterSecureStorage();
      var data = await loginServices.loginUser(
          emailTextController.text, passwordTextController.text);
      await storage.write(key: 'userId', value: data['user']['id'].toString());
      await storage.write(key: 'token', value: data['token'].toString());
      await storage.write(
          key: 'district_id', value: data['user']['district_id'].toString());
      var locationPermission = await Permission.location.status;
      var cameraPermission = await Permission.camera.status;
      if (locationPermission.isGranted && cameraPermission.isGranted) {
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => ResourceScreen());
      }
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
