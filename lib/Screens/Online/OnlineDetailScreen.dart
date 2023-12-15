import 'package:agri_farmers_app/Controllers/AdditionalScreenController.dart';
import 'package:agri_farmers_app/Controllers/AnimalHusbandryController.dart';
import 'package:agri_farmers_app/Controllers/BasicInfoController.dart';
import 'package:agri_farmers_app/Controllers/FIsheriesScreenController.dart';
import 'package:agri_farmers_app/Controllers/HorticultureScreenController.dart';
import 'package:agri_farmers_app/Controllers/LandWaterScreenController.dart';
import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/Controllers/SericultureScreenController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddAdditionalScreen.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddFarmScreen.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddFisherieScreen.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddLandWaterScreen.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddSericultureScreen.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAnimalHusbandryScreen.dart';
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
  // OnlineHomeController homeController = Get.find();
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
                trailing: data.verification == 'Submitted' ||
                        data.verification == 'Approved'
                    ? null
                    : IconButton(
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
                    itemCount: controller.farmerAgriLandList.length,
                    itemBuilder: (c, i) {
                      var agri = controller.farmerAgriLandList[i];
                      return ListTile(
                        onTap: () {
                          Get.lazyPut(() => FarmLandController());
                          FarmLandController farmLandController = Get.find();
                          farmLandController.getFarmerAgriLand(agri.id!.toInt(),
                              () {
                            reusableWidget.loader(context);
                          }, () {
                            Loader.hide();
                            Get.to(() => OnlineAddFarmScreen(),
                                arguments: [agri]);
                          }, () {
                            Loader.hide();
                          });
                        },
                        dense: true,
                        leading: const Icon(Icons.person),
                        title: Text(
                          agri.land_owner_name.toString(),
                          style: const TextStyle(fontSize: 13),
                        ),
                        subtitle: Text(
                          agri.district!.district_name.toString(),
                          style: const TextStyle(fontSize: 11),
                        ),
                        trailing: data.verification == 'Submitted' ||
                                data.verification == 'Approved'
                            ? null
                            : IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  openAgriDeleteDialog(agri.id!, context);
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
                      Get.delete<AdditionalScreenController>();
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
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.additionalDetails.length,
                  itemBuilder: (c, i) {
                    var additional = controller.additionalDetails[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                        dense: true,
                        onTap: () {
                          Get.lazyPut(() => AdditionalScreenController());
                          AdditionalScreenController
                              additionalScreenController = Get.find();
                          additionalScreenController
                              .getAdditionalDetails(additional.id!, () {
                            reusableWidget.loader(context);
                          }, () {
                            Loader.hide();
                            Get.to(() => OnlineAddAdditionalScreen(),
                                arguments: [additional]);
                          }, () {
                            Loader.hide();
                          });
                        },
                        leading: const Icon(Icons.person),
                        title: Text(
                          additional.ration_card_number.toString(),
                          style: const TextStyle(fontSize: 13),
                        ),
                        trailing: data.verification == 'Submitted' ||
                                data.verification == 'Approved'
                            ? null
                            : IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  openAdditionalDeleteDialog(
                                      additional.id!, context);
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
                      arguments: [data]);
                },
                child: Text(
                  'ADD HORTICULTURE',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.horticultureList.length,
                  itemBuilder: (c, i) {
                    var horti = controller.horticultureList[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                          dense: true,
                          onTap: () {
                            Get.lazyPut(() => HorticultureScreenController());
                            HorticultureScreenController
                                horticultureScreenController = Get.find();
                            horticultureScreenController.isEdit.value = true;
                            horticultureScreenController
                                .getHortiDetails(horti.id!, () {
                              reusableWidget.loader(context);
                            }, () {
                              Loader.hide();
                              Get.to(() => OnlineAddHorticultureScreen(),
                                  arguments: [horti]);
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
                          leading: Text(horti.location.toString()),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              openHorticultureDeleteDialog(horti.id!, context);
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
                onPressed: () {
                  Get.delete<LandWaterScreenController>();
                  Get.to(() => OnlineAddLandWaterScreen(), arguments: [data]);
                },
                child: Text(
                  'ADD LAND RESOURCE AND WATER CONSERVATION',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.landWaterList.length,
                  itemBuilder: (c, i) {
                    var land = controller.landWaterList[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                          dense: true,
                          onTap: () {
                            Get.lazyPut(() => LandWaterScreenController());
                            LandWaterScreenController
                                landWaterScreenController = Get.find();
                            landWaterScreenController.isEdit.value = true;
                            landWaterScreenController.getLandWaterData(land.id!,
                                () {
                              reusableWidget.loader(context);
                            }, () {
                              Loader.hide();
                              Get.to(() => OnlineAddLandWaterScreen(),
                                  arguments: [land]);
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
                          leading: Text(land.location.toString()),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              openLandDeleteDialog(land.id!, context);
                            },
                          )),
                    );
                  },
                ),
              ),
              MaterialButton(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                elevation: 0,
                onPressed: () {
                  Get.delete<FisheriesScreenController>();
                  Get.to(() => OnlineAddFisherieScreen(), arguments: [data]);
                },
                child: Text(
                  'ADD FISH POND',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.fisherieList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    var fish = controller.fisherieList[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                          dense: true,
                          onTap: () {
                            Get.lazyPut(() => FisheriesScreenController());
                            FisheriesScreenController
                                fisheriesScreenController = Get.find();
                            fisheriesScreenController.isEdit.value = true;
                            fisheriesScreenController.getFisherieData(fish.id!,
                                () {
                              reusableWidget.loader(context);
                            }, () {
                              Loader.hide();
                              Get.to(() => OnlineAddFisherieScreen(),
                                  arguments: [fish]);
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
                          leading: Text(fish.location.toString()),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              openFisheriesDeleteDialog(fish.id!, context);
                            },
                          )),
                    );
                  },
                ),
              ),
              MaterialButton(
                elevation: 0,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                onPressed: () {
                  Get.delete<AnimalHusbandryController>();
                  Get.to(() => OnlineAnimalHusbandryScreen(),
                      arguments: [data]);
                },
                child: Text(
                  'ANIMAL HUSBANDRY',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.husbandryList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    var animal = controller.husbandryList[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                          dense: true,
                          onTap: () {
                            Get.lazyPut(() => AnimalHusbandryController());
                            AnimalHusbandryController
                                animalHusbandryController = Get.find();
                            animalHusbandryController.isEdit.value = true;
                            animalHusbandryController
                                .getAnimalHusbandry(animal.id!, () {
                              reusableWidget.loader(context);
                            }, () {
                              Loader.hide();
                              Get.to(() => OnlineAnimalHusbandryScreen(),
                                  arguments: [animal]);
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
                          leading: Text(animal.location.toString()),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              openHusbandryDeleteDialog(animal.id!, context);
                            },
                          )),
                    );
                  },
                ),
              ),
              MaterialButton(
                elevation: 0,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.deepGreen)),
                onPressed: () {
                  Get.to(() => OnlineAddSericultureScreen(), arguments: [data]);
                },
                child: Text(
                  'ADD SERICULTURE',
                  style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
                ),
              ),
              Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.sericultureList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    var seri = controller.sericultureList[i];
                    return Card(
                      elevation: 0,
                      color: const Color(0xfff1f1f1),
                      child: ListTile(
                          dense: true,
                          onTap: () {
                            Get.lazyPut(() => SericultureScreenController());
                            SericultureScreenController
                                sericultureScreenController = Get.find();
                            sericultureScreenController.isEdit.value = true;
                            sericultureScreenController.getSericulture(seri.id!,
                                () {
                              reusableWidget.loader(context);
                            }, () {
                              Loader.hide();
                              Get.to(() => OnlineAddSericultureScreen(),
                                  arguments: [seri]);
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
                          leading: Text(seri.location.toString()),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              openSericultureDeleteDialog(seri.id!, context);
                            },
                          )),
                    );
                  },
                ),
              ),
              reusableWidget.textBoxSpace(),
              reusableWidget.textBoxSpace(),
              data.rejection_note != null
                  ? SizedBox(
                      width: Get.width,
                      child: Card(
                        color: const Color(0xfff1f1f1),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rejection Note:',
                                style:
                                    TextStyle(fontSize: 11, color: Colors.red),
                              ),
                              Text(
                                data.rejection_note.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
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
                            data.verification == 'Submitted' ||
                                    data.verification == 'Approved'
                                ? reusableWidget.rawSnackBar(
                                    'Already Submitted',
                                    const Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ))
                                : data.status == 'Incomplete'
                                    ? reusableWidget.rawSnackBar(
                                        'Application form Incomplete',
                                        const Icon(
                                          Icons.warning,
                                          color: Colors.red,
                                        ),
                                      )
                                    : controller.getAllSupervisor(() {
                                        reusableWidget.loader(context);
                                      }, () {
                                        Loader.hide();
                                        openApprovalDialog(context);
                                      }, () {
                                        Loader.hide();
                                      });
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
                                const Text('Submit for Approval')
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

  openApprovalDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text(
              'Send for Approval?',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              MaterialButton(
                elevation: 0,
                textColor: Colors.white,
                color: MyColors.deepGreen,
                onPressed: () {
                  if (controller.verification.value == 'Pending') {
                    controller.sendForApproval(data.id, () {
                      reusableWidget.loader(context);
                    }, () {
                      Loader.hide();
                      reusableWidget.rawSnackBar(
                        'Application send for Approval',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                      );
                      Navigator.pop(context);
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
                  } else if (controller.verification.value == 'Rejected') {
                    controller.sendForApproval(data.id, () {
                      reusableWidget.loader(context);
                    }, () {
                      Loader.hide();
                      reusableWidget.rawSnackBar(
                        'Application send for Approval',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                      );
                      controller.getAllFarmers('');
                      Navigator.pop(context);
                      Navigator.pop(context);
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
                child: const Text('Yes'),
              )
            ],
          );
        });
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
                    Navigator.pop(context);
                    Navigator.pop(context);
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
                onPressed: () {
                  Get.lazyPut(() => FarmLandController());
                  FarmLandController farmLandController = Get.find();
                  farmLandController.deleteFarmLand(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Successfully Deleted',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    controller.getFarmerFarmDetails(data.id, () {}, () {
                      Navigator.pop(context);
                    }, () {});
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Error Occured',
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
                    controller.getFarmerFarmDetails(data.id, () {}, () {
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
                    controller.getFarmerFarmDetails(data.id, () {}, () {
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

  openLandDeleteDialog(int id, BuildContext context) {
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
                  Get.lazyPut(() => LandWaterScreenController());
                  LandWaterScreenController landWaterScreenController =
                      Get.find();
                  landWaterScreenController.deleteLandWater(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Deleted successfully',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    controller.getFarmerFarmDetails(data.id, () {}, () {
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

  openFisheriesDeleteDialog(int id, BuildContext context) {
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
                  Get.lazyPut(() => FisheriesScreenController());
                  FisheriesScreenController fisheriesScreenController =
                      Get.find();
                  fisheriesScreenController.deleteFisheries(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Deleted successfully',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    controller.getFarmerFarmDetails(data.id, () {}, () {
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

  openHusbandryDeleteDialog(int id, BuildContext context) {
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
                  Get.lazyPut(() => AnimalHusbandryController());
                  AnimalHusbandryController animalHusbandryController =
                      Get.find();
                  animalHusbandryController.deleteHusbandry(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Deleted successfully',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    controller.getFarmerFarmDetails(data.id, () {}, () {
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

  openSericultureDeleteDialog(int id, BuildContext context) {
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
                  Get.lazyPut(() => SericultureScreenController());
                  SericultureScreenController sericultureScreenController =
                      Get.find();
                  sericultureScreenController.deleteSericulture(id, () {
                    reusableWidget.loader(context);
                  }, () {
                    Loader.hide();
                    reusableWidget.rawSnackBar(
                        'Deleted successfully',
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ));
                    controller.getFarmerFarmDetails(data.id, () {}, () {
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
