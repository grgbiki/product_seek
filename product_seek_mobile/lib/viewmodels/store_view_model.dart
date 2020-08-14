import 'package:flutter/material.dart';
import 'package:product_seek_mobile/repository/store_repository.dart';

class StoreViwModel extends ChangeNotifier {
  final StoreRepository storeRepo;

  StoreViwModel({@required this.storeRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() {
    notifyListeners();
  }

  getStoreInfoFromBackend(int id) => storeRepo.getStoreInfoFromBackend(id);

  getStoreInfo(int id) => storeRepo.getStoreInfo(id);
}
