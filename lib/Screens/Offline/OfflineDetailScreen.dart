import 'package:agri_farmers_app/Controllers/OfflineDataController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:agri_farmers_app/Screens/AddFarmScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfflineDetailScreen extends GetView<OfflineDataController> {
  OfflineDetailScreen({Key? key}) : super(key: key);
  var data = Get.arguments[0];
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.deepGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              leading: const Icon(Icons.person),
              title: Text(data.full_name),
              subtitle: Text(data.district_name),
              trailing: IconButton(
                icon: const Icon(Icons.wrap_text),
                onPressed: () {},
              ),
            ),
            MaterialButton(
              elevation: 0,
              color: MyColors.deepGreen,
              onPressed: () {
                Get.to(() => AddFarmScreen(), arguments: [data]);
              },
              child: const Text(
                'ADD FARM AND AGRICULTURE',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            reusableWidget.textBoxSpace(),
            MaterialButton(
              elevation: 0,
              color: MyColors.deepGreen,
              onPressed: () {},
              child: const Text(
                'ADDITIONAL DETAILS',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            reusableWidget.textBoxSpace(),
            MaterialButton(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.deepGreen)),
              elevation: 0,
              onPressed: () {},
              child: Text(
                'ADD HORTICULTURE',
                style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
              ),
            ),
            reusableWidget.textBoxSpace(),
            MaterialButton(
              elevation: 0,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.deepGreen)),
              onPressed: () {},
              child: Text(
                'ADDITIONAL DETAILS',
                style: TextStyle(fontSize: 13, color: MyColors.deepGreen),
              ),
            ),
            reusableWidget.textBoxSpace(),
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
            reusableWidget.textBoxSpace(),
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
            reusableWidget.textBoxSpace(),
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
            reusableWidget.textBoxSpace(),
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
          ],
        ),
      ),
    );
  }
}
