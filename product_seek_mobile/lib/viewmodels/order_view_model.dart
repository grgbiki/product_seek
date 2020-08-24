import 'package:flutter/material.dart';
import 'package:product_seek_mobile/repository/order_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository orderRepo;

  OrderViewModel({@required this.orderRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() async {
    notifyListeners();
  }
}
