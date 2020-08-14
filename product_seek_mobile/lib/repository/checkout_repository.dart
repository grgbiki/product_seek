import 'package:product_seek_mobile/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutRepository {
  SharedPreferences prefs;
  AppDatabase database;

  CheckoutRepository({this.prefs, this.database});
}
