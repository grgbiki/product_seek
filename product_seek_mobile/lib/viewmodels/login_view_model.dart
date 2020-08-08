import 'package:flutter/cupertino.dart';
import 'package:product_seek_mobile/repository/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository loginRepo;

  LoginViewModel({@required this.loginRepo});

  bool isLoggedIn;

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() async {
    isLoggedIn = await loginRepo.isLoggedIn();
    notifyListeners();
  }

  login({@required String email, @required String password}) {
    loginRepo.login(email: email, password: password);
  }
}
