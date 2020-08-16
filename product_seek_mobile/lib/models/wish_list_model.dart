import 'package:floor/floor.dart';

@entity
class WishlistModel {
  @PrimaryKey(autoGenerate: true)
  int id;
  @ColumnInfo(name: "product_id")
  String productId;
  @ColumnInfo(name: "user_id")
  int userId;

  WishlistModel(this.id, this.productId, this.userId);
}
