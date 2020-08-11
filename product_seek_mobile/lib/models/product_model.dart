import 'package:floor/floor.dart';

@entity
class ProductModel {
  @primaryKey
  int id;
  String title;
  List<String> images;
  String price;
  String description;
  @ColumnInfo(name: "category_id")
  String categoryId;
}
