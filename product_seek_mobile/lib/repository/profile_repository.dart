import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  SharedPreferences prefs;
  AppDatabase database;

  ProfileRepository({this.prefs, this.database});

  Stream<UserModel> getUserInfo() {
    return database.userDao
        .getUserDetail(prefs.containsKey(USER_ID) ? prefs.getInt(USER_ID) : 0);
  }
}
