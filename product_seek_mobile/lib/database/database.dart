import 'dart:async';

import 'package:floor/floor.dart';
import 'package:product_seek_mobile/database/dao/product_dao.dart';
import 'package:product_seek_mobile/database/dao/user_dao.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [UserModel, ProductModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  ProductDao get productDao;
}

//flutter packages pub run build_runner build
