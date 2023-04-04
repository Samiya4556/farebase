import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase/models/user_models.dart';
import 'package:firebase/service/currency_service.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class UserRepository {
  GetUserService getUserService = GetUserService();
  Box<UserModels>? userBox;

  Future<dynamic> getData() async {
    await openBox();
    if (userBox!.isEmpty) {
      return getUser();
    } else {
      return userBox;
    }
  }

  Future<dynamic> getUser() async {
    try {
      dynamic response = await getUserService.getUser();
      if (response == null) {
        return "Error: Response was null";
      }
      if (response is List<UserModels>) {
        await openBox();
        await writeToBox(response);
        return userBox;
      } else {
        return response;
      }
    } on DioError catch (error) {
      return "Error: ${error.toString()}";
    }
  }

  void registerAdapter() {
    Hive.registerAdapter(UserModelsAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(GeoAdapter());
    Hive.registerAdapter(CompanyAdapter());
  }

  Future<void> openBox() async {
    Directory appDocDir = await getApplicationSupportDirectory();
    Hive.init(appDocDir.path);
    userBox = await Hive.openBox<UserModels>("user");
  } Future<void> writeToBox(List<UserModels> data) async {
    await userBox!.clear();
    for (UserModels element in data) {
      await userBox!.add(element);
    }
  }

  Future<void> editElement(int indexOfElement, String newValue) async {
    UserModels? currentElement = userBox!.getAt(indexOfElement);
    currentElement!.name = newValue;
    await userBox!.putAt(indexOfElement, currentElement);
  }

  Future<void> deleteElement(int index) async {
    await userBox!.deleteAt(index);
  }
}
