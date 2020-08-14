import 'package:flutter/cupertino.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository productRepo;

  ProductViewModel({this.productRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  getProducts() => productRepo.getProducts();

  Stream<List<ProductModel>> getLocalProducts() =>
      productRepo.getLocalProducts();
}
