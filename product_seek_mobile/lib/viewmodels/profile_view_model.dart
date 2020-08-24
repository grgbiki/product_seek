import 'package:flutter/cupertino.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/repository/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository profileRepo;

  ProfileViewModel({@required this.profileRepo});

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() async {
    notifyListeners();
  }

  Future<UserModel> getUserData() => profileRepo.getUserInfo();

  Future<void> logOut() => profileRepo.logOut();

  postFeedback(String feedback, int userId) =>
      profileRepo.postFeedback(feedback, userId);
}
