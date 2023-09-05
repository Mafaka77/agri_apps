import 'dart:io';

import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/AgricultureFarmModel.dart';
import 'package:dio/dio.dart';
import '../Helpers/Repository.dart';
import '../Routes.dart';

class FarmLandServices extends BaseService {
  late Repository repository;
  FarmLandServices() {
    repository = Repository();
  }
  getLandHolding() async {
    return await repository.readData('land_holdings');
  }

  getOwnershipType() async {
    return await repository.readData('ownership_types');
  }

  getIrrigation() async {
    return await repository.readData('irrigation_infrastructures');
  }

  getEquipment() async {
    return await repository.readData('farm_equipment');
  }

  getKharifCrops() async {
    return await repository.readData('kharif_crops');
  }

  getRabiCrops() async {
    return await repository.readData('rabi_crops');
  }

  //ONLINE

  uploadImageOnline(File? file) async {
    try {
      FormData formdata = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file!.path,
        ),
      });

      var response =
          await client.post(Routes.UPLOAD_LANDHOLDING_FILE, data: formdata);
      var data = response.data['data'];
      print(data);
      return data;
    } catch (ex) {
      print(ex);
    }
  }

  submitFarmerAgriLand(
    AgricultureLandModel agricultureLandModel,
    var irrigation,
    var equipment,
    var kharifCrop,
    var rabiCrop,
  ) async {
    try {
      var response = await client.post(Routes.SUBMIT_AGRI_FARM, data: {
        'data': agricultureLandModel.toMap(),
        'infrastructure': irrigation,
        'equipment': equipment,
        'kharifCrop': kharifCrop,
        'rabiCrop': rabiCrop,
      });
      print(response.data);
      return response.data;
    } catch (ex) {
      return ex;
    }
  }

  Future<AgricultureLandModel> getFarmerAgriLand(int id) async {
    try {
      var response = await client.get(Routes.GET_FARMER_AGRI_LAND(id));
      var data = response.data['data'];
      return AgricultureLandModel.fromMap(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  updateFarmerAgriLand(
    int id,
    AgricultureLandModel agricultureLandModel,
    var irrigation,
    var equipment,
    var kharifCrop,
    var rabiCrop,
  ) async {
    try {
      var response =
          await client.put(Routes.UPDATE_FARMER_AGRI_LAND(id), data: {
        'data': agricultureLandModel.toMap(),
        'infrastructure': irrigation,
        'equipment': equipment,
        'kharifCrop': kharifCrop,
        'rabiCrop': rabiCrop,
      });
    } catch (ex) {
      print(ex);
    }
  }

  Future deleteFarm(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_FARMER_AGRI_LAND(id));
      print(response.statusCode);

      return response.data;
    } catch (ex) {
      print(ex);
      return Future.error(ex);
    }
  }
}
