import 'dart:io';

import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

class UserServices {
  Dio dio = Dio();

  Future<User> authLogin({String? email, String? password}) async {
    try {
      final data = await dio
          .post("$baseUrl/login",
              data: {"email": email, "password": password},
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) => true,
                  headers: {"Content-Type": "application/json"}))
          .then((response) {
        print("DATA API : ${response.data}");
        final User data = User.fromJson(response.data);
        if (response.statusCode == 200) {
          return data;
        } else {
          return data;
        }
      });

      return data;
    } on SocketException {
      throw Exception("Connection Problem");
    }
  }

  Future<User> authLogout({String? token}) async {
    try {
      final data = await dio
          .post("$baseUrl/logout",
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) => true,
                  headers: {
                    "Authorization": "Bearer $token",
                    "Content-Type": "application/json"
                  }))
          .then((response) {
        print("DATA API : ${response.data}");
        final User data = User.fromJson(response.data);
        if (response.statusCode == 200) {
          return data;
        } else {
          return data;
        }
      });

      return data;
    } on SocketException {
      throw Exception("Connection Problem");
    }
  }
}
