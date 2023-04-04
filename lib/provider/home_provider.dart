import 'package:firebase/models/user_models.dart';
import 'package:firebase/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';


class Homeprovider extends ChangeNotifier {
  Homeprovider() {
    getUser();
  }
  UserRepository userRepository = UserRepository();
  String error = "";
  bool isLoading = false;
  Box<UserModels>? data;
  void getUser() async {
    isLoading = true;
    notifyListeners();
    await userRepository.getUser().then((dynamic response) {
    userRepository.getData().then((dynamic response) {
      if (response is Box<UserModels>) {
        isLoading = false;
        data = response;
        notifyListeners();
      } else {
        isLoading = false;
        error = response;
        notifyListeners();
      }
    });
    });
}
  void editElementTitle(int index, String newValue) async {
    await userRepository.editElement(index, newValue);
    notifyListeners();
  }

  void deleteElement(int index) async {
    await userRepository.deleteElement(index);
  }
}
