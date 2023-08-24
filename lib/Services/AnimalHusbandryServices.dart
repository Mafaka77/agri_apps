import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/AnimalHusbandryModel.dart';
import 'package:agri_farmers_app/Routes.dart';

import '../Helpers/Repository.dart';

class AnimalHusbandryServices extends BaseService {
  late Repository repository;
  AnimalHusbandryServices() {
    repository = Repository();
  }
  getLiveStock() async {
    return await repository.readData('livestocks');
  }

  getTypeOfBreed() async {
    return await repository.readData('type_of_breeds');
  }

  getTypeOfFarm() async {
    return await repository.readData('type_of_farms');
  }

  getTypeOfPoultryFarm() async {
    return await repository.readData('type_of_poultry_farms');
  }

  getTypeOfPoultryBreed() async {
    return await repository.readData('type_of_poultry_breeds');
  }

  Future submitHusbandry(AnimalHusbandryModel model, var livestock, var farm,
      var breed, var poultryFarm, var poultryBreed) async {
    try {
      var response = await client.post(Routes.SUBMIT_ANIMAL_HUSBANDRY, data: {
        'data': model.toMap(),
        'livestock': livestock,
        'breed': breed,
        'farm': farm,
        'poultryFarm': poultryFarm,
        'poultryBreed': poultryBreed,
      });
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future<AnimalHusbandryModel> getAnimalHusbandry(int id) async {
    try {
      var response = await client.get(Routes.GET_ANIMAL_HUSBANDRY(id));
      var data = response.data['data'];
      return AnimalHusbandryModel.fromMap(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future updataAnimalHusbandry(
      int id,
      AnimalHusbandryModel model,
      var livestock,
      var typeOfFarm,
      var typeOfBreed,
      var typeOfPoultryFarm,
      var typeOfPoultryBreed) async {
    try {
      var response =
          await client.put(Routes.UPDATE_ANIMAL_HUSBANDRY(id), data: {
        'data': model.toMap(),
        'livestock': livestock,
        'farm': typeOfFarm,
        'breed': typeOfBreed,
        'poultryFarm': typeOfPoultryFarm,
        'poultryBreed': typeOfPoultryBreed
      });
      return response.data;
    } catch (ex) {}
  }

  Future deleteHusbandry(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_ANIMAL_HUSBANDRY(id));
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
