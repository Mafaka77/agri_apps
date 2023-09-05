import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Helpers/Repository.dart';
import 'package:agri_farmers_app/Models/LandWaterModel.dart';

import '../Routes.dart';

class LandWaterScreenServices extends BaseService {
  late Repository repository;
  LandWaterScreenServices() {
    repository = Repository();
  }

  getLandCrops() async {
    return await repository.readData('land_crops');
  }

  Future submitLandWater(LandWaterModel landWaterModel, var landCrops) async {
    try {
      print(landCrops);
      var response = await client.post(
        Routes.SUBMIT_LAND_WATER,
        data: {
          'data': landWaterModel.toMap(),
          'landCrops': landCrops,
        },
      );
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<LandWaterModel> getLandWater(int id) async {
    try {
      var response = await client.get(Routes.GET_LAND_WATER(id));
      var data = response.data['data'];
      return LandWaterModel.fromMap(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future updateLandWater(
      int id, LandWaterModel landWaterModel, var landCrops) async {
    try {
      var response = await client.put(Routes.UPDATE_LAND_WATER(id), data: {
        'data': landWaterModel.toMap(),
        'landCrops': landCrops,
      });
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future deleteLandWater(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_LAND_WATER(id));
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
