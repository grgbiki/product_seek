import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_config.dart';

class OrderModel {
  int id;
  String orderNumber;
  List<ProductModel> products;
  String status;
  double totalPrice;

  OrderModel(
      this.id, this.orderNumber, this.products, this.status, this.totalPrice);

  OrderModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_ORDER_ID];
    this.orderNumber = json[NetworkConfig.API_KEY_ORDER_NUMBER];
    this.status = json[NetworkConfig.API_KEY_ORDER_STATUS];
    this.totalPrice = json[NetworkConfig.API_KEY_ORDER_TOTAL].toDouble();
  }
}
