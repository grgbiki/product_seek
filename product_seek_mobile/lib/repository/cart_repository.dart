import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  SharedPreferences prefs;
  AppDatabase database;

  CartRepository({this.prefs, this.database});

  addItemToCart(CartItemModel cartItem) {
    database.cartDao.checkExistingItem(cartItem.product).then((cartItem) {
      if (cartItem != null) {
        print("Items exists");
      } else {
        database.cartDao.addItemToCart(cartItem);
      }
    });
  }

  Stream<List<CartItemModel>> getItemsFromCart() =>
      database.cartDao.getCartItems();
}
