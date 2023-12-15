import 'dart:async';

import 'package:agri_farmers_app/Screens/HomeScreen.dart';
import 'package:agri_farmers_app/Screens/LoginScreen.dart';
import 'package:agri_farmers_app/Screens/ResourceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PermissionStatus permission;
  String? myStorage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStorage();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    Timer(const Duration(seconds: 3), () => toRoutes());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void getStorage() async {
    const storage = FlutterSecureStorage();
    myStorage = await storage.read(key: 'token');
  }

  void toRoutes() async {
    permission = await Permission.location.status;
    myStorage != null
        ? Get.offAll(() => HomeScreen(), transition: Transition.cupertino)
        : !permission.isGranted
            ? Get.offAll(() => ResourceScreen())
            : Get.offAll(() => LoginScreen(), transition: Transition.cupertino);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Padding(
        padding: EdgeInsets.all(50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Agriculture Department, Mizoram',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _animationController,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 150,
                image: AssetImage('images/playstore.png'),
              ),
              Text(
                'FARMER REGISTRATION APPLICATION',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF2E6525)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
