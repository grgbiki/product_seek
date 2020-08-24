import 'package:product_seek_mobile/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  SharedPreferences prefs;
  AppDatabase database;

  OrderRepository({this.prefs, this.database});
}
