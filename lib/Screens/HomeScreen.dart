import 'package:agri_farmers_app/Controllers/HomeController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Services/HomeScreenServices.dart';
import 'package:agri_farmers_app/Widgets/OfflineDataWidget.dart';
import 'package:agri_farmers_app/Widgets/OnlineDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  HomeScreenServices homeScreenServices = Get.find(tag: 'homeScreenServices');
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FARMER REGISTRATION',
                    style: TextStyle(
                        color: MyColors.deepGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const Text(
                    'Agriculture Department,Mizoram',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => MaterialButton(
                          minWidth: Get.width * 0.4,
                          elevation: 0,
                          color: controller.isOnlineDataVisible.isTrue
                              ? MyColors.deepGreen
                              : Colors.black12,
                          onPressed: () {
                            controller.isOnlineDataVisible.value = true;
                            controller.isOfflineDataVisible.value = false;
                          },
                          child: Text(
                            'Online Data',
                            style: TextStyle(
                                color: controller.isOnlineDataVisible.isTrue
                                    ? Colors.white
                                    : MyColors.deepGreen),
                          ),
                        ),
                      ),
                      Obx(
                        () => MaterialButton(
                          minWidth: Get.width * 0.4,
                          elevation: 0,
                          color: controller.isOfflineDataVisible.isTrue
                              ? MyColors.deepGreen
                              : Colors.black12,
                          onPressed: () {
                            controller.isOnlineDataVisible.value = false;
                            controller.isOfflineDataVisible.value = true;
                          },
                          child: Text(
                            'Offline Data',
                            style: TextStyle(
                                color: controller.isOfflineDataVisible.isTrue
                                    ? Colors.white
                                    : MyColors.deepGreen),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.isOnlineDataVisible.value,
                      child: SizedBox(
                        height: Get.height * 0.85,
                        child: OnlineDataWidget(),
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                      visible: controller.isOfflineDataVisible.value,
                      child: SizedBox(
                        height: Get.height * 0.85,
                        child: const OfflineDataWidget(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }
}
