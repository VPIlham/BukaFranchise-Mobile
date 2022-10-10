import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:validators/sanitizers.dart';

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

  getListorderById(
      {String? search,
      int? pageSize = 7,
      String? status,
      String? sort = 'createdAt',
      String? direction = 'desc'}) async {
    try {
      final userId = await getUserId();
      final role = await getRoleUser();

      dio.options.queryParameters.clear();

      if (search != null && search != '') {
        dio.options.queryParameters.addAll({
          "filters[col][trxId]": search,
        });
      }

      if (pageSize != null) {
        dio.options.queryParameters.addAll({
          "pageSize": pageSize,
        });
      }

      if (status != null) {
        dio.options.queryParameters.addAll({
          "filters[col][status]": status,
        });
      }

      if (sort != null) {
        dio.options.queryParameters.addAll({
          "sort": sort,
        });
        dio.options.queryParameters.addAll({
          "direction": direction,
        });
      }

      if (role == 'seller') {
        dio.options.queryParameters.addAll({
          "filters[Item][UserId]": userId,
        });
      } else {
        dio.options.queryParameters.addAll({
          "filters[User][id]": userId,
        });
      }

      return await dio.get(
          "$baseUrl/orders?populate=Item.Brand,Item.Upload,User",
          options: myOption);
    } catch (e) {
      print('GET LIST TRX = $e');
    }
  }

  getOrderById({required id}) async {
    try {
      return await dio.get("$baseUrl/orders/$id?populate=*", options: myOption);
    } catch (e) {
      print('GET LIST TRX = $e');
    }
  }

  updateTransaction({required data, required id}) async {
    try {
      print('My Data = $data');
      return await dio.put("$baseUrl/orders/$id",
          data: data, options: myOption);
    } catch (e) {
      print('ERROR UPDATE TRX = $e');
    }
  }

  createWithdraw({required data}) async {
    try {
      print('Withdraw payload = $data');
      final token = await getToken();
      return await dio.post(
        "$baseUrl/withdraws",
        data: data,
        options: myOption.copyWith(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
    } catch (e) {
      print('ERROR CREATE WITHDRAW = $e');
    }
  }

  getListWithdraw(
      {int? pageSize = 40,
      String? status,
      String? sort = 'createdAt',
      String? direction = 'desc'}) async {
    try {
      final userId = await getUserId();

      if (pageSize != null) {
        dio.options.queryParameters.addAll({
          "pageSize": pageSize,
        });
      }

      if (sort != null) {
        dio.options.queryParameters.addAll({
          "sort": sort,
        });
        dio.options.queryParameters.addAll({
          "direction": direction,
        });
      }

      return await dio.get(
        "$baseUrl/withdraws?filters[col][UserId]=$userId",
        options: myOption,
      );
    } catch (e) {
      print('ERROR GET WITHDRAW = $e');
    }
  }
}
