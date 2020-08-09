import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:product_seek_mobile/app/app.dart';
import 'package:product_seek_mobile/database/database.dart';
import 'package:product_seek_mobile/repository/login_repository.dart';
import 'package:product_seek_mobile/repository/profile_repository.dart';
import 'package:product_seek_mobile/viewmodels/login_view_model.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Stetho.initialize();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final preferences = await SharedPreferences.getInstance();

  final loginViewModel = LoginViewModel(
      loginRepo: LoginRepository(prefs: preferences, database: database));
  loginViewModel.init();

  final profileViewModel = ProfileViewModel(
      profileRepo: ProfileRepository(prefs: preferences, database: database));
  profileViewModel.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginViewModel>.value(value: loginViewModel),
      ChangeNotifierProvider<ProfileViewModel>.value(value: profileViewModel),
    ],
    child: App(),
  ));
}
