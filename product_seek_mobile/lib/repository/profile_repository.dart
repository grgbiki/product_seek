import 'package:product_seek_mobile/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  SharedPreferences prefs;
  AppDatabase database;

  ProfileRepository({this.prefs, this.database});
}
