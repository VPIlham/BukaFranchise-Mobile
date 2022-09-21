import 'dart:async';

import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
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

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _controller.add(AuthenticationStatus.unauthenticated);
    await prefs.remove('userId');
    await prefs.remove('role');
    await prefs.remove('name');
    await prefs.remove('email');
  }

  void dispose() => _controller.close();

  Future<void> logIn({String? email, String? password}) async {
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
        print("DATA API LOGIN : $data");

        if (response.statusCode == 200) {
          //SAVE LOCAL STORAGE
          setUserId(data['id']);
          setName(data['name']);
          setRole(data['role']);
          setEmail(data['email']);

          //PENGHUBUNG KE BLOC
          _controller.add(AuthenticationStatus.authenticated);
          return data;
        } else {
          print('data tidak ada');
          return data;
        }
      });
    } catch (err) {
      print('ERROR = $err');
    }
  }
}
