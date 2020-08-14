import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/product_model.dart';

@entity
class CartItemModel {
  @PrimaryKey(autoGenerate: true)
  final int id;
  ProductModel product;
  int quantity;
  double totalPrice;

  CartItemModel(this.id, this.product, this.quantity, this.totalPrice);
}
