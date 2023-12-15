import 'package:agri_farmers_app/Controllers/HomeController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/Online/ProfileScreen.dart';
import 'package:agri_farmers_app/Services/HomeScreenServices.dart';
import 'package:agri_farmers_app/Widgets/OfflineDataWidget.dart';
import 'package:agri_farmers_app/Widgets/OnlineDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                  SizedBox(
                    height: Get.height * 0.3,
                    width: 200,
                    child: SvgPicture.asset(
                      'images/logo_agri.svg', // Replace with your SVG image path
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  color: MyColors.deepGreen,
                  onPressed: () {
                    Get.to(() => ProfileScreen());
                  },
                  icon: const Icon(
                    Icons.person,
                  ),
                )
                // PopupMenuButton(
                //   icon: Icon(
                //     Icons.more_vert_sharp,
                //     color: MyColors.deepGreen,
                //   ),
                //   onSelected: (value) {
                //     if (value == '0') {
                //       // logoutDialog(context);
                //     }
                //   },
                //   itemBuilder: (BuildContext bc) {
                //     return [
                //       const PopupMenuItem(
                //         value: '0',
                //         child: Text(
                //           "Logout",
                //           style: TextStyle(fontSize: 14),
                //         ),
                //       ),
                //       // const PopupMenuItem(
                //       //   value: '/about',
                //       //   child: Text("About"),
                //       // ),
                //       // const PopupMenuItem(
                //       //   value: '/contact',
                //       //   child: Text("Contact"),
                //       // )
                //     ];
                //   },
                // )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Obx(
                      //   () => MaterialButton(
                      //     minWidth: Get.width * 0.4,
                      //     elevation: 0,
                      //     color: controller.isOnlineDataVisible.isTrue
                      //         ? MyColors.deepGreen
                      //         : Colors.black12,
                      //     onPressed: () {
                      //       controller.isOnlineDataVisible.value = true;
                      //       controller.isOfflineDataVisible.value = false;
                      //     },
                      //     child: Text(
                      //       'Online Data',
                      //       style: TextStyle(
                      //           color: controller.isOnlineDataVisible.isTrue
                      //               ? Colors.white
                      //               : MyColors.deepGreen),
                      //     ),
                      //   ),
                      // ),
                      // Obx(
                      //   () => MaterialButton(
                      //     minWidth: Get.width * 0.4,
                      //     elevation: 0,
                      //     color: controller.isOfflineDataVisible.isTrue
                      //         ? MyColors.deepGreen
                      //         : Colors.black12,
                      //     onPressed: () {
                      //       controller.isOnlineDataVisible.value = false;
                      //       controller.isOfflineDataVisible.value = true;
                      //     },
                      //     child: Text(
                      //       'Offline Data',
                      //       style: TextStyle(
                      //           color: controller.isOfflineDataVisible.isTrue
                      //               ? Colors.white
                      //               : MyColors.deepGreen),
                      //     ),
                      //   ),
                      // ),
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
