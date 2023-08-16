import 'package:agri_farmers_app/BaseService.dart';
import 'package:agri_farmers_app/Routes.dart';

class LoginServices extends BaseService {
  Future loginUser(String email, String password) async {
    try {
      var response = await client.post(
        Routes.LOGIN,
        data: {'email': email, 'password': password},
      );

      return response.data;
    } catch (ex) {
      print(ex);
    }
  }
}
