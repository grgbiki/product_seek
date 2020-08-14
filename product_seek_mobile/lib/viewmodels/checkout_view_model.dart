import 'package:flutter/material.dart';
import 'package:product_seek_mobile/repository/checkout_repository.dart';

class CheckoutViewModel extends ChangeNotifier {
  final CheckoutRepository checkoutRepo;

  CheckoutViewModel({@required this.checkoutRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  addItemToCart() {}

  getItemsFromCart() {}
}
