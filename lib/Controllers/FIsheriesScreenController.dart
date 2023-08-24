import 'package:agri_farmers_app/Models/FishModel.dart';
import 'package:agri_farmers_app/Models/FisheriesModel.dart';
import 'package:agri_farmers_app/Services/FisheriesScreenServices.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FisheriesScreenController extends GetxController {
  FisheriesScreenServices services = Get.find(tag: 'fisherieScreenServices');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //DATA
  var f_id = 0.obs;
  var fisherID = TextEditingController();
  var location = TextEditingController();
  var nurseryPondText = TextEditingController();
  var nuseryPond = 0.obs;
  var rearingPondText = TextEditingController();
  var rearingPond = 0.obs;
  var grewOutPondText = TextEditingController();
  var grewOutPond = 0.obs;
  var totalPond = 0.obs;
  var totalAreaSown = TextEditingController();
  var fishCulturedList = [];
  var fishHatchery = ''.obs;
  var fishCulturedData = <FishModel>[].obs;
  //

  var isEdit = false.obs;

  submitFisheries(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();
    try {
      totalPond.value =
          nuseryPond.value + rearingPond.value + grewOutPond.value;
      var fisherie = FisheriesModel();
      fisherie.fisheries_id = fisherID.text;
      fisherie.location = location.text;
      fisherie.acres_or_hectares = 'Acres';
      fisherie.nursery_ponds = nuseryPond.value;
      fisherie.rearing_ponds = rearingPond.value;
      fisherie.grew_out_ponds = grewOutPond.value;
      fisherie.total_ponds = totalPond.value;
      fisherie.total_area = totalAreaSown.text;
      fisherie.fish_hatchery = fishHatchery.value;
      fisherie.farmers_id = farmerId;
      var data = await services.submitFisheries(fisherie, fishCulturedList);
      onSuccess();
    } catch (ex) {
      onError();
      print(ex);
    }
  }

  getFisherieData(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.getFisherieData(id);
      f_id.value = data.id!;
      fisherID.text = data.fisheries_id!;
      location.text = data.location!;
      nurseryPondText.text = data.nursery_ponds!.toString();
      nuseryPond.value = data.nursery_ponds!;
      rearingPondText.text = data.rearing_ponds.toString();
      rearingPond.value = data.rearing_ponds!;
      grewOutPondText.text = data.grew_out_ponds.toString();
      grewOutPond.value = data.grew_out_ponds!;
      fishCulturedList.clear();
      fishCulturedList.addAll(data.fish!.map((e) => e.id));
      fishCulturedData.clear();
      fishCulturedData.addAll(data.fish!);
      totalAreaSown.text = data.total_area!;
      fishHatchery.value = data.fish_hatchery!;
      onSuccess();
    } catch (ex) {
      onError();
      print(ex);
    }
  }

  updateFisheries(int farmerId, Function onLoading, Function onSuccess,
      Function onError) async {
    onLoading();

    try {
      var fish = FisheriesModel();
      fish.id = f_id.value;
      fish.fisheries_id = fisherID.text;
      fish.location = location.text;
      fish.acres_or_hectares = 'Acres';
      fish.nursery_ponds = nuseryPond.value;
      fish.rearing_ponds = rearingPond.value;
      fish.grew_out_ponds = grewOutPond.value;
      fish.total_ponds = totalPond.value;
      fish.total_area = totalAreaSown.text;
      fish.fish_hatchery = fishHatchery.value;
      fish.farmers_id = farmerId;
      var data =
          await services.updateFisheries(f_id.value, fish, fishCulturedList);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }

  deleteFisheries(
      int id, Function onLoading, Function onSuccess, Function onError) async {
    onLoading();
    try {
      var data = await services.deleteFisheries(id);
      onSuccess();
    } catch (ex) {
      onError();
    }
  }
}
