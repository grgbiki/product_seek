import 'package:floor/floor.dart';

@entity
class WishlistModel {
  @PrimaryKey(autoGenerate: true)
  int id;
  @ColumnInfo(name: "product_id")
  String productId;

  WishlistModel(this.id, this.productId);
}
