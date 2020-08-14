import 'package:flutter/cupertino.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository productRepo;

  ProductViewModel({this.productRepo});

  init() async {
    await initializeProducts();
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  Future<void> initializeProducts() {
    print("ramailo");
    List<ProductModel> products = new List<ProductModel>();
    products.add(new ProductModel(
        1,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        2,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        3,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        4,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        5,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        6,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        7));
    products.add(new ProductModel(
        1,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        8,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        9,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        10,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        11,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        12,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        13,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        14,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        15,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        16,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        17,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        18,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        19,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        20,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        21,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));
    products.add(new ProductModel(
        22,
        "Apple",
        '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
        120,
        "This is an apple",
        1));

    return productRepo.addProducts(products);
  }

  Stream<List<ProductModel>> getLocalProducts() =>
      productRepo.getLocalProducts();
}
