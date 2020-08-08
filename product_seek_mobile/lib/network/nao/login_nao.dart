import 'package:meta/meta.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';

class LoginNAO {
  static Future<UserModel> login(
      {@required String email, @required String password}) {
    NetworkUtil().post(url: NetworkEndpoints.LOGIN_API, body: {
      NetworkConfig.API_KEY_USER_EMAIL: email,
      NetworkConfig.API_KEY_USER_PASSWORD: password
    }).then((response) {
      print(response);
      return UserModel.fromJson(response);
    });
  }

  static Future<UserModel> register({
    @required String name,
    @required String email,
    @required String password,
    @required String confirmPassword,
    @required String address,
    @required String number,
  }) {
    NetworkUtil().post(url: NetworkEndpoints.LOGIN_API, body: {
      NetworkConfig.API_KEY_USER_NAME: name,
      NetworkConfig.API_KEY_USER_EMAIL: email,
      NetworkConfig.API_KEY_USER_PASSWORD: password,
      NetworkConfig.API_KEY_USER_PASSWORD_CONFIRMATION: confirmPassword,
      NetworkConfig.API_KEY_USER_ADDRESS: address,
      NetworkConfig.API_KEY_USER_ROLE: "user",
      NetworkConfig.API_KEY_USER_PHONE_NUMBER: number,
    }).then((response) {
      print(response);
      return UserModel.fromJson(response);
    });
  }
}
