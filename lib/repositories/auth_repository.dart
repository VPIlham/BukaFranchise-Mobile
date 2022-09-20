import 'dart:async';
import 'dart:io';

import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  Dio dio = Dio();

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  void logOut() {
    print('MASUK LOGOUT');
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<void> logIn({String? email, String? password}) async {
    try {
      print('aaaaaaaaa');
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
          _controller.add(AuthenticationStatus.authenticated);
          return data;
        } else {
          print('data tidak ada');
          return data;
        }
      });
    } catch (err) {
      print('ERR = $err');
    }
  }
}
