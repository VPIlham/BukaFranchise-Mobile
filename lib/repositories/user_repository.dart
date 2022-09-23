import 'dart:convert';
import 'dart:io';

import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

class UserRepository {
  var dio = Dio();

  final myOption = Options(
      followRedirects: false,
      validateStatus: (status) => true,
      headers: {"Content-Type": "application/json"});

  Future<User> getUser({id}) async {
    try {
      final result = await dio
          .get("$baseUrl/users/$id?populate=Brand.Item,Upload",
              options: myOption)
          .then((response) {
        print("==== GET USER ==== \n ${response.data}");
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

  updateProfile({required id, name, phoneNumber, image}) async {
    try {
      var myData;
      if (image == null) {
        myData = FormData.fromMap({
          "data": jsonEncode({
            "name": name,
            "phoneNumber": phoneNumber,
          })
        });
      } else {
        String fileName = image.path.split('/').last;
        myData = FormData.fromMap({
          "image": await MultipartFile.fromFile(image.path, filename: fileName),
          "data": jsonEncode({
            "name": name,
            "phoneNumber": phoneNumber,
          })
        });
      }
      return await dio.put("$baseUrl/users/$id",
          data: myData,
          options: myOption
              .copyWith(headers: {'Content-Type': 'multipart/form-data'}));
    } catch (e) {
      print('ERROR = $e');
    }
  }
}
