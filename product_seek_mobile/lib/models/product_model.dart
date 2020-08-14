import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:product_seek_mobile/network/network_config.dart';

@entity
class ProductModel {
  @primaryKey
  int id;
  String title;
  String images;
  double price;
  String description;

  ProductModel(this.id, this.title, this.images, this.price, this.description);

  ProductModel.fromJson(dynamic json) {
    this.id = json[NetworkConfig.API_KEY_PRODUCT_ID];
    this.title = json[NetworkConfig.API_KEY_PRODUCT_TITLE];
    this.price = json[NetworkConfig.API_KEY_PRODUCT_PRICE].toDouble();
    this.description = json[NetworkConfig.API_KEY_PRODUCT_DESCRIPTION];
    this.images = jsonEncode(json[NetworkConfig.API_KEY_PRODUCT_IMAGE]);
  }
}
