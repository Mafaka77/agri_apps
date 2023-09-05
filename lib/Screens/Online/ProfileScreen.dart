import 'package:agri_farmers_app/Controllers/ProfileScreenController.dart';
import 'package:agri_farmers_app/Controllers/ResourceScreenController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/Online/PermissionScreen.dart';
import 'package:agri_farmers_app/Screens/Online/PrivacyPolicyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../LoginScreen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileScreenController>(
        init: ProfileScreenController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: MyColors.deepGreen,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      logoutDialog(context);
                    },
                    icon: const Icon(
                      Icons.logout,
                    ))
              ],
            ),
            body: Obx(
              () => controller.isLoading.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Stack(
                        alignment: Alignment.center,
                        textDirection: TextDirection.rtl,
                        fit: StackFit.loose,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: MyColors.deepGreen,
                            height: Get.height,
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome back,',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Obx(
                                  () => Text(
                                    controller.user['name'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                reusableWidget.textBoxSpace(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Obx(
                                          () => Text(
                                            controller.unsubmitted.value
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xffe94343),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Unsubmitted',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Obx(
                                          () => Text(
                                            controller.submitted.value
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xffcd9f27),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Submitted',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Obx(
                                          () => Text(
                                            controller.approved.value
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xffedffea),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Approved',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: Get.height * 0.16,
                            height: Get.height,
                            width: Get.width,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xfff3f5f7),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(children: [
                                Obx(() => controller.isDownloadButton.isTrue
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Card(
                                          elevation: 10,
                                          child: ListTile(
                                            onTap: () {
                                              downloadDialog(context);
                                            },
                                            dense: true,
                                            title: const Text(
                                                'Re-Download Resources'),
                                          ),
                                        ),
                                      )
                                    : Container()),
                                Obx(() => controller.isPermissionButton.isTrue
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Card(
                                          elevation: 10,
                                          child: ListTile(
                                            onTap: () {
                                              Get.to(() => PermissionScreen());
                                            },
                                            dense: true,
                                            title:
                                                const Text('App Permissions'),
                                          ),
                                        ),
                                      )
                                    : Container()),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Card(
                                    elevation: 10,
                                    child: ListTile(
                                      dense: true,
                                      title: const Text('Terms & Conditions'),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Card(
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => PrivacyPolicyPage());
                                      },
                                      dense: true,
                                      title: const Text('Privacy Policy'),
                                      trailing: IconButton(
                                          onPressed: () {
                                            Get.to(() => PrivacyPolicyPage());
                                          },
                                          icon: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.4,
                                ),
                                const Column(
                                  children: [
                                    Text('Design and Developed by'),
                                    Text('Mizoram State e-Governance Society')
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  logoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text(
              'Logout?',
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () async {
                  var storage = const FlutterSecureStorage();
                  await storage.deleteAll();
                  Get.offAll(() => LoginScreen());
                },
                color: MyColors.deepGreen,
                elevation: 0,
                textColor: Colors.white,
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  downloadDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text(
              'Do you want to download resources?',
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () async {
                  Get.put(ResourceScreenController());
                  ResourceScreenController resourceScreenController =
                      Get.find();
                  resourceScreenController.cleateDatabaseTable();
                  resourceScreenController.downloadResources(() {
                    reusableWidget.rawSnackBar(
                        'Downloading.....',
                        const Icon(
                          Icons.downloading_outlined,
                          color: Colors.green,
                        ));
                    reusableWidget.loader(context);
                  }, () {
                    Navigator.pop(context);
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                      'Data Downloaded',
                      const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    );
                  }, () {
                    Navigator.pop(context);
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                      'Error Occured',
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    );
                  });
                },
                color: MyColors.deepGreen,
                elevation: 0,
                textColor: Colors.white,
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }
}
