import 'dart:io';

import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

class UserRepository {
  var dio = Dio();

  Future<User> getUser({id}) async {
    try {
      final result = await dio
          .get("$baseUrl/users/$id?populate=Brand.Item,Upload",
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) => true,
                  headers: {"Content-Type": "application/json"}))
          .then((response) {
        print("===== GET USER ==== \n ${response.data}");
        var data = response.data['data'];
        if (response.statusCode == 200) {
          return User(
            id: data['id'],
            name: data['name'],
            email: data['email'],
            role: data['role'],
            phoneNumber: data['phoneNumber'],
            image: data['imageId'],
          );
        } else {
          return data;
        }
      });
      return result;
    } on SocketException {
      throw Exception("Connection Problem");
    }
  }
}
