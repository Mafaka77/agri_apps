import 'package:agri_farmers_app/Controllers/OnlineHomeController.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/Online/OnlineAddBasicInfoScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../MyColors.dart';
import '../Screens/Online/OnlineDetailScreen.dart';

class OnlineDataWidget extends StatelessWidget {
  OnlineDataWidget({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnlineHomeController>(
        init: OnlineHomeController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: MaterialButton(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: MyColors.deepGreen),
              ),
              elevation: 0,
              color: MyColors.deepGreen,
              onPressed: () {
                Get.to(() => OnlineAddBasicInfoScreen());
              },
              child: const Text(
                'Add Farmers Online',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const ClassicHeader(
                completeText: 'Finished',
                refreshingIcon: CupertinoActivityIndicator(),
              ),
              footer: CustomFooter(builder: (c, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator(
                    color: Colors.white,
                  );
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("Release to load more");
                } else {
                  body = const Text("No more Data");
                }
                return Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 30.0,
                  child: Center(child: body),
                );
              }),
              controller: controller.refreshController,
              onRefresh: () {
                controller.getAllFarmers('');
              },
              onLoading: () {
                controller.onLoadMore();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: Get.height,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.8,
                              child: CupertinoSearchTextField(
                                controller: controller.searchTextController,
                                onSuffixTap: () {
                                  controller.searchTextController.clear();
                                  controller.getAllFarmers('');
                                },
                                onSubmitted: (value) {
                                  controller.getAllFarmers(value);
                                },
                                prefixInsets: const EdgeInsets.all(10),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.grey,
                                ),
                                placeholderStyle:
                                    reusableWidget.textBoxTextSyle(),
                                decoration: BoxDecoration(
                                  border: Border.all(color: MyColors.deepGreen),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.filter_alt,
                                color: MyColors.deepGreen,
                              ),
                            )
                          ],
                        ),
                        Obx(
                          () => controller.isDataLoading.isTrue
                              ? Center(
                                  child: CupertinoActivityIndicator(
                                    color: MyColors.deepGreen,
                                  ),
                                )
                              : controller.onlineFarmerList.isEmpty
                                  ? const Center(
                                      child: Text('No Data'),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.onlineFarmerList.length,
                                      itemBuilder: (context, index) {
                                        var data =
                                            controller.onlineFarmerList[index];
                                        return ListTile(
                                          dense: true,
                                          onTap: () async {
                                            await controller
                                                .getFarmerFarmDetails(data.id!,
                                                    () {
                                              reusableWidget.loader(context);
                                            }, () {
                                              Loader.hide();
                                              controller.checkVerification(
                                                  data.id!, () {
                                                reusableWidget.loader(context);
                                              }, () {
                                                Loader.hide();
                                                Get.to(
                                                    () => OnlineDetailScreen(),
                                                    arguments: [data]);
                                              }, () {
                                                Loader.hide();
                                                reusableWidget.rawSnackBar(
                                                    'Error Occured!',
                                                    const Icon(
                                                      Icons.warning,
                                                      color: Colors.red,
                                                    ));
                                              });
                                            }, () {
                                              Loader.hide();
                                            });
                                          },
                                          title: Row(
                                            children: [
                                              Text(data.full_name.toString()),
                                              const Text(' | '),
                                              Text(
                                                data.status.toString(),
                                                style: TextStyle(
                                                    color: data.status ==
                                                            'Incomplete'
                                                        ? Colors.red
                                                        : MyColors.deepGreen),
                                              ),
                                            ],
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(data.district_name
                                                  .toString()),
                                              const Text('   |   '),
                                              Text(
                                                data.verification.toString(),
                                                style: TextStyle(
                                                  color: data.verification ==
                                                          'Pending'
                                                      ? const Color(0xffbdbdbd)
                                                      : data.verification ==
                                                              'Submitted'
                                                          ? Colors.pinkAccent
                                                          : data.verification ==
                                                                  'Approved'
                                                              ? const Color(
                                                                  0xff59964f)
                                                              : const Color(
                                                                  0xffe94343),
                                                ),
                                              )
                                            ],
                                          ),
                                          trailing: const Icon(
                                              Icons.keyboard_arrow_right),
                                        );
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
