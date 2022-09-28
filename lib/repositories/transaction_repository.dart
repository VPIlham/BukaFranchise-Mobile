import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

class TransactionRepository {
  var dio = Dio();

  var myOption = Options(
      followRedirects: false,
      validateStatus: (status) => true,
      headers: {"Content-Type": "application/json"});

  createTransaction({required data}) async {
    try {
      print('My Data = $data');
      return await dio.post("$baseUrl/orders", data: data, options: myOption);
    } catch (e) {
      print('ERROR CREATE TRX = $e');
    }
  }
}