import 'package:floor/floor.dart';

@entity
class ProductModel {
  @primaryKey
  int id;
  String title;
  String images;
  double price;
  String description;
  @ColumnInfo(name: "category_id")
  int categoryId;

  ProductModel(this.id, this.title, this.images, this.price, this.description,
      this.categoryId);
}
