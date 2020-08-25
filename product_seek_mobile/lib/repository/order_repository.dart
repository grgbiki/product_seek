import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/order_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/utils/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  SharedPreferences prefs;
  AppDatabase database;

  OrderRepository({this.prefs, this.database});

  Future<List<OrderModel>> getOrders(int id) {
    return NetworkUtil()
        .get(url: NetworkEndpoints.USER_ORDERS_API + id.toString())
        .then((response) {
      if (response != null) {
        List<OrderModel> orderModel;
        orderModel =
            (response as List).map((i) => OrderModel.fromJson(i)).toList();
        print(orderModel[0].product.title);
        return orderModel;
      } else {
        print("Could not fetch product data");
      }
    });
  }
}
