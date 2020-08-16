import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/wish_list_model.dart';
import 'package:product_seek_mobile/repository/wishlist_repository.dart';

class WishlistViewModel extends ChangeNotifier {
  final WishlistRepository wishlistRepo;

  WishlistViewModel({@required this.wishlistRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  getWishlist(int userId) {}
  addWishList(WishlistModel wishlistModel) {}
  removeWishlist(WishlistModel wishlistModel) {}
}
