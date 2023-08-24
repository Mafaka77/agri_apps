import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Helpers/Repository.dart';
import 'package:agri_farmers_app/Models/SericultureModel.dart';
import 'package:agri_farmers_app/Routes.dart';

class SericultureScreenServices extends BaseService {
  late Repository repository;
  SericultureScreenServices() {
    repository = Repository();
  }

  getAllSilkworm() async {
    return await repository.readData('silkworms');
  }

  Future submitSericulture(
      SericultureModel sericultureModel, var silkwormReared) async {
    try {
      print(sericultureModel.toMap());
      var response = await client.post(Routes.SUBMIT_SERICULTURE,
          data: {'data': sericultureModel.toMap(), 'reared': silkwormReared});
    } catch (ex) {}
  }

  Future<SericultureModel> getSericulture(int id) async {
    try {
      var response = await client.get(Routes.GET_SERICULTURE(id));
      var data = response.data['data'];
      return SericultureModel.fromMap(data);
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future updateSericulture(
      int id, SericultureModel sericultureModel, var silkwormReared) async {
    try {
      var response = await client.put(Routes.UPDATE_SERICULTURE(id), data: {
        'data': sericultureModel.toMap(),
        'reared': silkwormReared,
      });
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future deleteSericulture(int id) async {
    try {
      var response = await client.delete(Routes.DELETE_SERICULTURE(id));
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
