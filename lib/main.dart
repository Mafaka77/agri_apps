import 'package:agri_farmers_app/Services/AdditionalScreenServices.dart';
import 'package:agri_farmers_app/Services/BasicInfoServices.dart';
import 'package:agri_farmers_app/Services/FarmLandServices.dart';
import 'package:agri_farmers_app/Services/HomeScreenServices.dart';
import 'package:agri_farmers_app/Services/HorticultureScreenServices.dart';
import 'package:agri_farmers_app/Services/LoginServices.dart';
import 'package:agri_farmers_app/Services/OnlineHomeScreenServices.dart';
import 'package:agri_farmers_app/Services/ResourceServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';

String? myStorage;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BasicInfoServices(), tag: 'basicInfoServices');
  Get.put(HomeScreenServices(), tag: 'homeScreenServices');
  Get.put(ResourceServices(), tag: 'resourceServices');
  Get.put(FarmLandServices(), tag: 'farmLandServices');
  Get.put(LoginServices(), tag: 'loginServices');
  Get.put(OnlineHomeScreenServices(), tag: 'onlineHomeServices');
  Get.put(AdditionalScreenServices(), tag: 'additionalScreenServices');
  Get.put(HorticultureScreenServices(), tag: 'horticultureServices');

  const storage = FlutterSecureStorage();
  myStorage = await storage.read(key: 'token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agriculture',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: myStorage != null ? HomeScreen() : LoginScreen(),
      // home: ResourceScreen(),
    );
  }
}
