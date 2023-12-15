import 'package:agri_farmers_app/Screens/SplashScreen.dart';
import 'package:agri_farmers_app/Services/AdditionalScreenServices.dart';
import 'package:agri_farmers_app/Services/AnimalHusbandryServices.dart';
import 'package:agri_farmers_app/Services/BasicInfoServices.dart';
import 'package:agri_farmers_app/Services/FarmLandServices.dart';
import 'package:agri_farmers_app/Services/FisheriesScreenServices.dart';
import 'package:agri_farmers_app/Services/HomeScreenServices.dart';
import 'package:agri_farmers_app/Services/HorticultureScreenServices.dart';
import 'package:agri_farmers_app/Services/LandWaterScreenServices.dart';
import 'package:agri_farmers_app/Services/LoginServices.dart';
import 'package:agri_farmers_app/Services/Offline/OfflineBasicInfoServices.dart';
import 'package:agri_farmers_app/Services/Offline/OfflineFarmServices.dart';
import 'package:agri_farmers_app/Services/OnlineHomeScreenServices.dart';
import 'package:agri_farmers_app/Services/ProfileScreenServices.dart';
import 'package:agri_farmers_app/Services/ResourceServices.dart';
import 'package:agri_farmers_app/Services/SericultureScreenServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/ResourceScreen.dart';

String? myStorage;
late PermissionStatus permission;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //OFFLINE
  Get.put(OfflineBasicInfoServices(), tag: 'offlineBasicInfoServices');
  Get.put(OfflineFarmServices(), tag: 'offlineFarmServices');
  //ONLINE
  Get.put(BasicInfoServices(), tag: 'basicInfoServices');
  Get.put(HomeScreenServices(), tag: 'homeScreenServices');
  Get.put(ResourceServices(), tag: 'resourceServices');
  Get.put(FarmLandServices(), tag: 'farmLandServices');
  Get.put(LoginServices(), tag: 'loginServices');
  Get.put(OnlineHomeScreenServices(), tag: 'onlineHomeServices');
  Get.put(AdditionalScreenServices(), tag: 'additionalScreenServices');
  Get.put(HorticultureScreenServices(), tag: 'horticultureServices');
  Get.put(LandWaterScreenServices(), tag: 'landWaterScreenServices');
  Get.put(FisheriesScreenServices(), tag: 'fisherieScreenServices');
  Get.put(AnimalHusbandryServices(), tag: 'animalHusbandryServices');
  Get.put(SericultureScreenServices(), tag: 'sericultureScreenServices');
  Get.put(ProfileScreenServices(), tag: 'profileScreenServices');
  const storage = FlutterSecureStorage();
  permission = await Permission.location.status;
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
        // home: myStorage != null
        //     ? HomeScreen()
        //     : !permission.isGranted
        //         ? ResourceScreen()
        //         : LoginScreen(),
        home: const SplashScreen());
  }
}
