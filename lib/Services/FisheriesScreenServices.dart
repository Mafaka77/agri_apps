import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/FisheriesModel.dart';
import 'package:agri_farmers_app/Routes.dart';

import '../Helpers/Repository.dart';

class FisheriesScreenServices extends BaseService {
  late Repository repository;
  FisheriesScreenServices() {
    repository = Repository();
  }

  getFish() async {
    return await repository.readData('fish');
  }

  Future submitFisheries(
      FisheriesModel fisheriesModel, List fishCultured) async {
    try {
      var response = await client.post(Routes.SUBMIT_FISHERIES,
          data: {'data': fisheriesModel.toMap(), 'fish': fishCultured});
      return response.data;
    } catch (ex) {
      Future.error(ex);
    }
  }

  Future<FisheriesModel> getFisherieData(int id) async {
    try {
      var response = await client.get(Routes.GET_FISHERIE_DATA(id));
      var data = response.data['data'];
      return FisheriesModel.fromMap(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future updateFisheries(
      int id, FisheriesModel fisheriesModel, var fishCultured) async {
    try {
      var response = await client.put(Routes.UPDATE_FISHERIES(id), data: {
        'data': fisheriesModel.toMap(),
        'fish': fishCultured,
      });
    } catch (ex) {}
  }

  Future deleteFisheries(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_FISHERIES(id));
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
