import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:bukafranchise/utils/constant.dart';
import 'package:http_parser/http_parser.dart';

class ProductRepository {
  var dio = Dio();

  var myOption = Options(
      followRedirects: false,
      validateStatus: (status) => true,
      headers: {"Content-Type": "application/json"});

  getAllProducts({String? search, int? pageSize = 7}) async {
    try {
      dio.options.queryParameters.clear();

      if (search != null) {
        dio.options.queryParameters.addAll({
          "filters[col][name]": search,
        });
      }

      if (pageSize != null) {
        dio.options.queryParameters.addAll({
          "pageSize": pageSize,
        });
      }

      return await dio.get(
          "$baseUrl/items?sort=createdAt&direction=desc&populate=Upload,Brand",
          options: myOption);
    } catch (e) {
      print('ERROR = $e');
    }
  }

  getMyProduct() async {
    try {
      final userId = await getUserId();
      return await dio.get(
          "$baseUrl/items?page=1&pageSize=10&userId=$userId&populate=Brand,User,Upload");
    } catch (e) {
      print('ERROR GET MY PRODUCT = $e');
    }
  }

  getProductId({required id}) async {
    try {
      return await dio.get("$baseUrl/items/$id?populate=Brand,Upload",
          options: myOption);
    } catch (e) {
      print('ERROR GET PRODUCT ID = $e');
    }
  }

  deleteProduct({required id}) async {
    try {
      return await dio.delete("$baseUrl/items/$id", options: myOption);
    } catch (e) {
      print('ERROR DELETE PRODUCT ID = $e');
    }
  }

  addProduct({required data, required image}) async {
    try {
      FormData myData;
      print('MY DATA = $data');
      if (image == null) {
        myData = FormData.fromMap({"data": jsonEncode(data)});
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
          "data": jsonEncode(data)
        });
      }
      return await dio.post(
        "$baseUrl/items",
        data: myData,
        options: myOption.copyWith(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );
    } catch (e) {
      print('ERROR ADD PRODUCT = $e');
    }
  }

  updateProduct({required id, required data, image}) async {
    try {
      FormData myData;
      print('MY DATA UPDATE = $data');
      if (image == null) {
        myData = FormData.fromMap({"data": jsonEncode(data)});
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
          "data": jsonEncode(data)
        });
      }
      return await dio.put(
        "$baseUrl/items/$id",
        data: myData,
        options: myOption.copyWith(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );
    } catch (e) {
      print('ERROR UPDATE PRODUCT = $e');
    }
  }
}
