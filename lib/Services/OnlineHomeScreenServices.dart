import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Models/FarmerModel.dart';
import 'package:agri_farmers_app/Routes.dart';

class OnlineHomeScreenServices extends BaseService {
  Future<List<FarmerModel>> getAllFarmers(int userId, int offset, int limit,
      String search, String sortBy, String filterBy) async {
    try {} catch (ex) {}
    var response = await client.get(Routes.GET_ALL_FARMERS(userId), data: {
      'offset': offset,
      'limit': limit,
      'search': search,
      'sortBy': sortBy,
      'filterBy': filterBy
    });
    var data = response.data['data'];
    return FarmerModel.fromOnlineJsonList(data);
  }

  Future getFarmerFarmDetails(int farmerId) async {
    try {
      var response = await client.get(Routes.GET_AGRI_FARM(farmerId));
      var data = response.data;
      return data;
      // return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future checkStatus(int farmerId) async {
    var response = await client.get(Routes.CHECK_STATUS(farmerId));
    return response.data;
  }

  Future checkVerification(int id) async {
    try {
      var resoponse = await client.get(Routes.CHECK_VERIFICATION(id));
      var data = resoponse.data['data'];
      return data;
    } catch (ex) {
      return Future.error(ex);
    }
  }

  Future sendForApproval(int id) async {
    try {
      var response = await client.get(Routes.SEND_FOR_APPROVAL(id));
      return response.data['data'];
    } catch (ex) {
      Future.error(ex);
    }
  }

  Future getAllSupervisor(int districtId) async {
    try {
      var response = await client.get(Routes.GET_ALL_SUPERVISOR(districtId));
      print(response.data);
    } catch (ex) {}
  }
}
