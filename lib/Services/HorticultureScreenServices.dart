import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/HorticultureModel.dart';
import 'package:agri_farmers_app/Routes.dart';

import '../Helpers/Repository.dart';

class HorticultureScreenServices extends BaseService {
  late Repository repository;
  HorticultureScreenServices() {
    repository = Repository();
  }
  getKharifCrops() async {
    return await repository.readData('kharif_crops');
  }

  getRabiCrops() async {
    return await repository.readData('rabi_crops');
  }

  getOrchards() async {
    return await repository.readData('orchards');
  }

  getPlantation() async {
    return await repository.readData('plantations');
  }

  getGreenHousePlant() async {
    return await repository.readData('green_house_plants');
  }

  //ONLINE
  Future submitHortiDetails(HorticultureModel model, List kharifCrops,
      List rabiCrops, List orchards, List plantation, List greenhouse) async {
    var response = await client.post(Routes.SUBMIT_HORTI_DETAILS, data: {
      'data': model.toMap(),
      'kharifCrops': kharifCrops,
      'rabiCrops': rabiCrops,
      'orchards': orchards,
      'plantation': plantation,
      'greenHouse': greenhouse,
    });
  }

  Future<HorticultureModel> getHortiDetail(int id) async {
    try {
      var response = await client.get(Routes.GET_HORTI_DETAIL(id));
      print(response.data);
      var data = response.data['data'];
      return HorticultureModel.fromMap(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future updateHortiDetails(int id, HorticultureModel model, List kharifCrops,
      List rabiCrops, List orchards, List plantation, List greenhouse) async {
    try {
      var response = await client.put(Routes.UPDATE_HORTI_DETAILS(id), data: {
        'data': model.toMap(),
        'kharifCrops': kharifCrops,
        'rabiCrops': rabiCrops,
        'orchards': orchards,
        'plantation': plantation,
        'greenHouse': greenhouse,
      });
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future deleteHorticulture(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_HORTICULTURE(id));
      return response.statusCode;
    } catch (ex) {}
  }
}
