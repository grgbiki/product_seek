import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  SharedPreferences prefs;
  AppDatabase database;

  ProductRepository({this.prefs, this.database});

  Stream<List<ProductModel>> getLocalProducts() =>
      database.productDao.getProducts();

  Future<void> addProducts(List<ProductModel> products) {
    return database.productDao.addProducts(products);
  }
}
