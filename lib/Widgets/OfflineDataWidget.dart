import 'package:agri_farmers_app/Controllers/OfflineDataController.dart';
import 'package:agri_farmers_app/Screens/Offline/OfflineAddBasicInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MyColors.dart';
import '../Screens/Offline/OfflineDetailScreen.dart';

class OfflineDataWidget extends StatelessWidget {
  const OfflineDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfflineDataController>(
        init: OfflineDataController(),
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
                Get.to(() => OfflineAddBasicInfoScreen());
              },
              child: const Text(
                'Add Farmers Offline',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
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
                    const Text('Offline data'),
                    Obx(() {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.farmerList.length,
                          itemBuilder: (c, i) {
                            var data = controller.farmerList[i];
                            return ListTile(
                              onTap: () async {
                                await controller
                                    .getFarmerBankDetails(data.ids!);
                                Get.to(
                                  () => OfflineDetailScreen(),
                                  arguments: [data],
                                );
                              },
                              dense: true,
                              leading: const Icon(Icons.person),
                              title: Text(
                                data.full_name.toString(),
                              ),
                              subtitle: Text(data.district_name.toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.keyboard_arrow_right),
                                onPressed: () {},
                              ),
                            );
                          });
                    }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
