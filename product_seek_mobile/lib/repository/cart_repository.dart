import 'package:product_seek_mobile/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  SharedPreferences prefs;
  AppDatabase database;

  CartRepository({this.prefs, this.database});
}
