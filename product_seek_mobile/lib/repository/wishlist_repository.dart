import 'package:product_seek_mobile/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistRepository {
  SharedPreferences prefs;
  AppDatabase database;

  WishlistRepository({this.prefs, this.database});
}
