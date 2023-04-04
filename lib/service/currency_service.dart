import 'package:dio/dio.dart';
import 'package:firebase/models/user_models.dart';


class GetUserService {
  Future<dynamic> getUser() async {
    try {
      Response response =
          await Dio().get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => UserModels.fromJson(e))
            .toList();
      } else {
        return response.statusMessage.toString();
      }
    } on DioError catch (e) {
      return e.message.toString();
    }
  }
}
