import 'dart:async';
import 'dart:convert';
import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  error,
  submitting,
  unauthenticated
}

class AuthRepository {
  Dio dio = Dio();

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  void setUserId(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', value.toString());
  }

  void setRole(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', value.toString());
  }

  void setName(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', value.toString());
  }

  void setEmail(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', value.toString());
  }

  void setToken(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', value.toString());
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('role');
    await prefs.remove('name');
    await prefs.remove('token');
    await prefs.remove('email');
    await prefs.remove('brandId');
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  // void dispose() => _controller.close();

  Future<void> login({String? email, String? password}) async {
    try {
      _controller.add(AuthenticationStatus.submitting);
      return await dio
          .post("$baseUrl/auth/login",
              data: {"email": email, "password": password},
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) => true,
                  headers: {"Content-Type": "application/json"}))
          .then((response) {
        final data = response.data['data'];
        print("=== DATA API LOGIN ===  \n$data");

        if (response.statusCode == 200) {
          //SAVE LOCAL STORAGE
          setUserId(data['id']);
          setName(data['name']);
          setRole(data['role']);
          setEmail(data['email']);
          setToken(response.data['jwt']);

          //PENGHUBUNG KE BLOC
          _controller.add(AuthenticationStatus.authenticated);
          return data;
        } else {
          _controller.add(AuthenticationStatus.error);
          return data;
        }
      });
    } catch (err) {
      _controller.add(AuthenticationStatus.error);
      print('ERROR LOGIN = $err');
    }
  }

  Future<void> register({
    required String? name,
    required String? email,
    required String? password,
    required String? role,
    int? totalEmployee,
    String? nameBrand,
    String? startOperation,
    String? categoryBrand,
  }) async {
    try {
      var myData = '';

      if (role == 'seller') {
        myData = jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "role": role,
          "brand": {
            "name": nameBrand,
            "totalEmployees": totalEmployee,
            "startOperation": startOperation,
            "category": categoryBrand,
          }
        });
      } else {
        myData = jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "role": role,
        });
      }

      return await dio
          .post("$baseUrl/auth/register",
              data: myData,
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) => true,
                  headers: {"Content-Type": "application/json"}))
          .then((response) {
        final data = response.data['data'];

        if (response.statusCode == 200) {
          print('DATA BERHASIL DIBUAT');
          return data;
        } else {
          print('DATA GAGAL DIBUAT');
          return data;
        }
      });
    } catch (err) {
      print('ERROR = $err');
    }
  }
}
