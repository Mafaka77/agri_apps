import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Routes.dart';

class ProfileScreenServices extends BaseService {
  Future getProfile(int id) async {
    try {
      var response = await client.get(Routes.GET_PROFILE(id));
      return response.data;
    } catch (ex) {
      return Future.error(ex);
    }
  }
}
