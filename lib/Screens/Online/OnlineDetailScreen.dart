import 'package:agri_farmers_app/Controllers/AdditionalScreenController.dart';
import 'package:agri_farmers_app/Controllers/BasicInfoController.dart';
import 'package:agri_farmers_app/Controllers/HorticultureScreenController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddAdditionalScreen.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddFarmScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../../Controllers/FarmLandControleer.dart';
import 'OnlineAddBasicInfoScreen.dart';
import 'OnlineAddHorticultureScreen.dart';

class OnlineDetailScreen extends GetView<OnlineHomeController> {
  OnlineDetailScreen({Key? key}) : super(key: key);
  var data = Get.arguments[0];
  ReusableWidget reusableWidget = ReusableWidget();
  OnlineHomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.deepGreen,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Farmer Registration Details'),
              reusableWidget.twoLine(),
              ListTile(
                onTap: () async {
                  Get.lazyPut(() => BasicInfoController());
                  BasicInfoController basicInfoController = Get.find();
                  basicInfoController.getFarmerBasicInfo(data.id, () {
                    reusableWidget.loader(context);
                  }, () {
                    basicInfoController.checkIsEdit.value = true;
                    Loader.hide();
                    Get.to(() => OnlineAddBasicInfoScreen());
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                      'Error Occured!!',
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    );
                  });
                },
                dense: true,
                leading: const Icon(Icons.person),
                title: Text(
                  data.full_name,
                  style: const TextStyle(fontSize: 13),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      data.district_name,
                      style: const TextStyle(fontSize: 11),
                    ),
                    const Text('  |  '),
                    Text(
                      data.phone_no,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.lazyPut(() => BasicInfoController());
                    openDeleteDialog(data.id, context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
              Divider(
                color: MyColors.deepGreen,
              ),
              const Text(
                'Compulsory Details for Farmer',
                style: TextStyle(fontSize: 13),
              ),
              reusableWidget.twoLine(),
              reusableWidget.textBoxSpace(),
              MaterialButton(
                elevation: 0,
                color: MyColors.deepGreen,
                onPressed: () {
                  Get.delete<FarmLandController>();
                  Get.to(() => OnlineAddFarmScreen(), arguments: [data]);
                },
                child: const Text(
                  'ADD FARM AND AGRICULTURE',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
              Obx(
                () => ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeController.farmerAgriLandList.length,
                    itemBuilder: (c, i) {
                      var data = homeController.farmerAgriLandList[i];
                      return ListTile(
                        onTap: () {
                          Get.lazyPut(() => FarmLandController());
                          FarmLandController farmLandController = Get.find();
                          farmLandController.getFarmerAgriLand(data.id!.toInt(),
                              () {
                            reusableWidget.loader(context);
                          }, () {
                            Loader.hide();
                            Get.to(() => OnlineAddFarmScreen(),
                                arguments: [data]);
                          }, () {
                            Loader.hide();
                          });
                        },
                        dense: true,
                        leading: const Icon(Icons.person),
                        title: Text(
                          data.land_owner_name.toString(),
                          style: const TextStyle(fontSize: 13),
                        ),
                        subtitle: Text(
                          data.district!.district_name.toString(),
                          style: const TextStyle(fontSize: 11),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            openAgriDeleteDialog(data.id!, context);
                          },
                        ),
                      );
                    }),
              ),
              Obx(
                () => AbsorbPointer(
                  absorbing:
                      controller.additionalDetails.isEmpty ? false : true,
                  child: MaterialButton(
                    elevation: 0,
                    color: controller.additionalDetails.isEmpty
                        ? MyColors.deepGreen
                        : Colors.green[500],
                    onPressed: () {
                      Get.to(() => OnlineAddAdditionalScreen(),
                          arguments: [data]);
                    },
                    child: const Text(
                      'ADDITIONAL DETAILS',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.additionalDetails.length,
                  itemBuilder: (c, i) {
                    var data = controller.additionalDetails[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                        onTap: () {
                          Get.lazyPut(() => AdditionalScreenController());
                          AdditionalScreenController
                              additionalScreenController = Get.find();
                          additionalScreenController
                              .getAdditionalDetails(data.id!, () {
                            reusableWidget.loader(context);
                          }, () {
                            Loader.hide();
                            Get.to(() => OnlineAddAdditionalScreen(),
                                arguments: [data]);
                          }, () {
                            Loader.hide();
                          });
                        },
                        leading: const Icon(Icons.person),
                        title: Text(
                          data.ration_card_number.toString(),
                          style: const TextStyle(fontSize: 13),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            openAdditionalDeleteDialog(data.id!, context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                color: MyColors.deepGreen,
              ),
              const Text(
                'Other Properties of Farmer',
                style: TextStyle(fontSize: 13),
              ),
              reusableWidget.twoLine(),
              reusableWidget.textBoxSpace(),
              MaterialButton(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                elevation: 0,
                onPressed: () {
                  Get.delete<HorticultureScreenController>();
                  Get.to(() => OnlineAddHorticultureScreen(),
                      arguments: [data.id]);
                },
                child: Text(
                  'ADD HORTICULTURE',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.horticultureList.length,
                  itemBuilder: (c, i) {
                    var data = controller.horticultureList[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                          onTap: () {
                            Get.lazyPut(() => HorticultureScreenController());
                            HorticultureScreenController
                                horticultureScreenController = Get.find();
                            horticultureScreenController.isEdit.value = true;
                            horticultureScreenController
                                .getHortiDetails(data.id!, () {
                              reusableWidget.loader(context);
                            }, () {
                              Loader.hide();
                              Get.to(() => OnlineAddHorticultureScreen(),
                                  arguments: [data.farmers_id]);
                            }, () {
                              Loader.hide();
                              reusableWidget.rawSnackBar(
                                  'Error Occured! Try Again',
                                  const Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ));
                            });
                          },
                          leading: Text(data.location.toString()),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              openHorticultureDeleteDialog(data.id!, context);
                            },
                          )),
                    );
                  },
                ),
              ),
              Divider(
                color: MyColors.deepGreen,
              ),
              MaterialButton(
                elevation: 0,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                onPressed: () {},
                child: Text(
                  'ADD LAND RESOURCE AND WATER CONSERVATION',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              MaterialButton(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                elevation: 0,
                onPressed: () {},
                child: Text(
                  'ADD FISH POND',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              MaterialButton(
                elevation: 0,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                onPressed: () {},
                child: Text(
                  'ANIMAL HUSBANDRY',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              MaterialButton(
                elevation: 0,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                onPressed: () {},
                child: Text(
                  'ADD SERICULTURE',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              reusableWidget.textBoxSpace(),
              reusableWidget.textBoxSpace(),
              Card(
                color: const Color(0xfff1f1f1),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'If all sections are complete you can mark this Registration for Supervisor Approval',
                        style: TextStyle(fontSize: 12),
                      ),
                      Obx(
                        () => InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            if (controller.verification.value == 'Pending') {
                              controller.sendForApproval(data.id, () {
                                reusableWidget.loader(context);
                              }, () {
                                Loader.hide();
                              }, () {
                                Loader.hide();
                                reusableWidget.rawSnackBar(
                                  'Error Occured!',
                                  const Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                );
                              });
                            }
                          },
                          child: Card(
                            elevation: 0,
                            child: Row(
                              children: [
                                Checkbox(
                                  value:
                                      controller.verification.value == 'Pending'
                                          ? false
                                          : controller.verification.value ==
                                                  'Approved'
                                              ? true
                                              : controller.verification.value ==
                                                      'Submitted'
                                                  ? true
                                                  : false,
                                  onChanged: (val) {},
                                ),
                                const Text('Ready for Approval')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              reusableWidget.textBoxSpace(),
              reusableWidget.textBoxSpace(),
            ],
          ),
        ),
      ),
    );
  }

  openDeleteDialog(int id, BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () {
                  BasicInfoController basicInfoController = Get.find();
                  basicInfoController.deleteFarmer(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Deleted Successfully',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    controller.getAllFarmers('');
                    Get.back();
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Error Occured!!',
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                        ));
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

  openAgriDeleteDialog(int id, BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () {},
                color: MyColors.deepGreen,
                elevation: 0,
                textColor: Colors.white,
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  openAdditionalDeleteDialog(int id, BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () {
                  Get.lazyPut(() => AdditionalScreenController());
                  AdditionalScreenController additionalScreenController =
                      Get.find();
                  additionalScreenController.deleteAdditionalDetail(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Deleted successfully',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    homeController.getFarmerFarmDetails(data.id, () {}, () {
                      Navigator.pop(context);
                    }, () {});
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Error Occured!!',
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                        ));
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

  openHorticultureDeleteDialog(int id, BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                onPressed: () {
                  Get.lazyPut(() => HorticultureScreenController());
                  HorticultureScreenController horticultureScreenController =
                      Get.find();
                  horticultureScreenController.deleteHorticulture(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Deleted successfully',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    homeController.getFarmerFarmDetails(data.id, () {}, () {
                      Navigator.pop(context);
                    }, () {});
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Error Occured!!',
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                        ));
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
