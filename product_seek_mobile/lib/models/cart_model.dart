import 'package:floor/floor.dart';

@entity
class CartItemModel {
  @PrimaryKey(autoGenerate: true)
  final int id;
  String product;
  int quantity;
  @ColumnInfo(name: "total_price")
  double totalPrice;
  String status;

  CartItemModel(
      this.id, this.product, this.quantity, this.totalPrice, this.status);
}
