import 'package:flutter/material.dart';
import 'package:product_seek_mobile/repository/cart_repository.dart';

class CartViewModel extends ChangeNotifier {
  final CartRepository cartRepo;

  CartViewModel({@required this.cartRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  addItemToCart() {}

  getItemsFromCart() {}
}