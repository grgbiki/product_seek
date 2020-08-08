import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/network/nao/login_nao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

class LoginRepository {
  SharedPreferences prefs;
  AppDatabase database;

  LoginRepository({this.prefs, this.database});

  static const String _IS_LOGGED_IN = "is_logged_in";

  void register({
    @required String name,
    @required String email,
    @required String password,
    @required String confirmPassword,
    @required String address,
    @required String number,
  }) {
    LoginNAO.register(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            address: address,
            number: number)
        .then((userModel) async {
      database.userDao.addUserData(userModel);
      await prefs.setBool(_IS_LOGGED_IN, true);
    });
  }

  void login({@required String email, @required String password}) {
    LoginNAO.login(email: email, password: password).then((userModel) async {
      database.userDao.addUserData(userModel);
      await prefs.setBool(_IS_LOGGED_IN, true);
    });
  }

  Future<bool> isLoggedIn() async {
    return prefs.containsKey(_IS_LOGGED_IN);
  }
}
