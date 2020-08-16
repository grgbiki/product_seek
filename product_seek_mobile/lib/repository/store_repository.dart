import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/store_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreRepository {
  SharedPreferences prefs;
  AppDatabase database;

  StoreRepository({this.prefs, this.database});

  getStoreInfoFromBackend(int id) {
    NetworkUtil()
        .get(url: NetworkEndpoints.STORE_INFO + id.toString())
        .then((response) {
      if (response != null) {
        StoreModel store = StoreModel.fromJson(response);
        database.storeDao.addStore(store);
      }
    });
  }

  Stream<StoreModel> getStoreInfo(int id) {
    return database.storeDao.getStoreFromId(id);
  }
}
