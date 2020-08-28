import 'package:flutter/material.dart';
import 'package:product_seek_mobile/repository/store_repository.dart';

class StoreViewModel extends ChangeNotifier {
  final StoreRepository storeRepo;

  StoreViewModel({@required this.storeRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  getStoreInfoFromBackend(int id) => storeRepo.getStoreInfoFromBackend(id);

  getStoreInfo(int id) => storeRepo.getStoreInfo(id);

  getStoreItems(int id) => storeRepo.getStoreItems(id);
}
