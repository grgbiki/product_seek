import 'package:product_seek_mobile/models/product_model.dart';

class OrderModel {
  int id;
  String orderNumber;
  List<ProductModel> products;
  int userId;
  String status;
  double totalPrice;
}
