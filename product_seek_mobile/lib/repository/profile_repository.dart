import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  SharedPreferences prefs;
  AppDatabase database;

  ProfileRepository({this.prefs, this.database});

  Future<UserModel> getUserInfo() {
    return database.userDao
        .getUserDetail(prefs.containsKey(USER_ID) ? prefs.getInt(USER_ID) : 0);
  }

  Future<void> logOut() async {
    database.cartDao.remoteItems();
    database.userDao.remoteItems();
    userDetails = null;
    globalIsLoggedIn = false;
    await prefs.clear();
  }

  postFeedback(String feedback, int userId) {
    NetworkUtil().post(url: NetworkEndpoints.FEEDBACK_API, body: {
      NetworkConfig.API_KEY_FEEDBACK: feedback,
      NetworkConfig.API_KEY_FEEDBACK_USER_ID: userId.toString()
    });
  }
}
