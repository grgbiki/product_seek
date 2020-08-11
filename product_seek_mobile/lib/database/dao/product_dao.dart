import 'package:floor/floor.dart';
import 'package:product_seek_mobile/models/product_model.dart';

@dao
abstract class ProductDao {
  @Query("SELECT * FROM ProductModel LIMIT 30")
  Stream<List<ProductModel>> getProducts();

  @Query("SELECT * FROM ProductModel WHERE category_id =:categoryId LIMIT 30")
  Stream<List<ProductModel>> getProductsByCategory(int categoryId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addProduct(ProductModel product);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addProducts(List<ProductModel> product);

  @update
  Future<void> updateProduct(ProductModel product);

  @delete
  Future<void> removeProduct(ProductModel product);
}
