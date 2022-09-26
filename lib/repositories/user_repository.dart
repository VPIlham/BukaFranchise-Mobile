import 'dart:convert';
import 'dart:io';

import 'package:bukafranchise/models/user.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

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
          .then((response) async {
        print("==== GET USER ==== \n ${response.data}");
        var data = response.data['data'];
        if (response.statusCode == 200) {
          //kalau dia seller maka simpan brandId kalo buyer akan null
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('brandId',
              data['Brand'] == null ? '' : data['Brand']['id'].toString());

          return User(
              id: data['id'],
              name: data['name'],
              email: data['email'],
              role: data['role'],
              phoneNumber: data['phoneNumber'],
              image: data['Upload']?['path'] ?? '',
              bank: data['bank_name'] ?? '',
              norek: data['bank_account'] ?? '',
              balance: int.parse(data['balance']));
        } else {
          return data;
        }
      });
      return result;
    } on SocketException {
      throw Exception("Connection Problem");
    }
  }

  updateProfile({required id, name, phoneNumber, image, norek, bank}) async {
    try {
      FormData myData;

      if (image == null) {
        myData = FormData.fromMap({
          "data": jsonEncode({
            "name": name,
            "phoneNumber": phoneNumber,
            "bank_account": norek,
            "bank_name": bank,
          })
        });
      } else {
        String fileName = image.path.split('/').last;

        myData = FormData.fromMap({
          "image": await MultipartFile.fromFile(
            image.path,
            filename: fileName,
            contentType: MediaType(
              'image',
              p.extension(image.path),
            ),
          ),
          "data": jsonEncode({
            "name": name,
            "phoneNumber": phoneNumber,
            "bank_account": norek,
            "bank_name": bank,
          })
        });
      }
      return await dio.put(
        "$baseUrl/users/$id",
        data: myData,
        options: myOption.copyWith(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );
    } catch (e) {
      print('ERROR = $e');
    }
  }

  getSummary() async {
    try {
      final id = await getUserId();
      return await dio.get("$baseUrl/summary/$id", options: myOption);
    } catch (e) {
      print('ERROR SUMMARY = $e');
    }
  }
}
