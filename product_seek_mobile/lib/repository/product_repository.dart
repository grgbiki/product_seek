import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  SharedPreferences prefs;
  AppDatabase database;

  ProductRepository({this.prefs, this.database});

  getProducts() {
    NetworkUtil().get(url: NetworkEndpoints.PRODUCT_API).then((response) async {
      if (response != null) {
        List<ProductModel> myModels;
        myModels =
            (response as List).map((i) => ProductModel.fromJson(i)).toList();
        await database.productDao.addProducts(myModels);
      } else {
        print("Could not fetch product data");
      }
    });
  }

  Stream<List<ProductModel>> getLocalProducts() =>
      database.productDao.getProducts();

  Future<void> addProducts(List<ProductModel> products) {
    return database.productDao.addProducts(products);
  }
}
