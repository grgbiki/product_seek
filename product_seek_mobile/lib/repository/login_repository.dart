import 'dart:async';

import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

class LoginRepository {
  SharedPreferences prefs;
  AppDatabase database;

  LoginRepository({this.prefs, this.database});
  var _isSuccessfulLogin = StreamController<bool>.broadcast();

  static const String _IS_LOGGED_IN = "is_logged_in";

  String _serverMessage = "";

  register({
    @required String name,
    @required String email,
    @required String password,
    @required String confirmPassword,
    @required String address,
    @required String number,
  }) {
    _serverMessage = "";
    NetworkUtil().post(url: NetworkEndpoints.REGISTER_API, body: {
      NetworkConfig.API_KEY_USER_NAME: name,
      NetworkConfig.API_KEY_USER_EMAIL: email,
      NetworkConfig.API_KEY_USER_PASSWORD: password,
      NetworkConfig.API_KEY_USER_PASSWORD_CONFIRMATION: confirmPassword,
      NetworkConfig.API_KEY_USER_ADDRESS: address,
      NetworkConfig.API_KEY_USER_ROLE: "user",
      NetworkConfig.API_KEY_USER_PHONE_NUMBER: number,
    }).then((response) async {
      if (response != null) {
        UserModel userModel = UserModel.fromJson(response["user"]);
        database.userDao.addUserData(userModel);
        await prefs.setBool(_IS_LOGGED_IN, true);
        _isSuccessfulLogin.add(true);
      } else {
        _serverMessage = response["message"];
        await prefs.setBool(_IS_LOGGED_IN, false);
        _isSuccessfulLogin.add(false);
      }
    });
  }

  login({@required String email, @required String password}) {
    _serverMessage = "";
    NetworkUtil().post(url: NetworkEndpoints.LOGIN_API, body: {
      NetworkConfig.API_KEY_USER_EMAIL: email,
      NetworkConfig.API_KEY_USER_PASSWORD: password
    }).then((response) async {
      if (response.toString().contains("access_token")) {
        UserModel userModel = UserModel.fromJson(response["user"]);
        database.userDao.addUserData(userModel);
        await prefs.setBool(_IS_LOGGED_IN, true);
        _isSuccessfulLogin.add(true);
      } else {
        _serverMessage = response["message"];
        await prefs.setBool(_IS_LOGGED_IN, false);
        _isSuccessfulLogin.add(false);
      }
    });
  }

  Future<bool> isLoggedIn() async {
    print(prefs.containsKey(_IS_LOGGED_IN));
    return prefs.containsKey(_IS_LOGGED_IN);
  }

  Stream<bool> getLoginResponse() {
    return _isSuccessfulLogin.stream;
  }

  getErrorMessage() {
    return _serverMessage;
  }
}
