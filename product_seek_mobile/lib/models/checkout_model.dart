import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/cart_model.dart';

@entity
class CheckoutModel {
  @PrimaryKey(autoGenerate: true)
  final int id;
  List<CartItemModel> prductList;
  double total;
  bool status;

  CheckoutModel(this.id, this.prductList, this.total);
}
