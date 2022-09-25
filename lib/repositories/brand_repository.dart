import 'dart:convert';

import 'package:bukafranchise/models/brand.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:dio/dio.dart';

class BrandRepository {
  var dio = Dio();

  var myOption = Options(
      followRedirects: false,
      validateStatus: (status) => true,
      headers: {"Content-Type": "application/json"});

  getAllBrand() async {
    try {
      return await dio.get(
          "$baseUrl/brands?sort=createdAt&direction=desc&populate=Upload",
          options: myOption);
    } catch (e) {
      print('ERROR ALL BRAND = $e');
    }
  }

  getBrandById({id}) async {
    try {
      return await dio
          .get("$baseUrl/brands/$id?populate=User,Item", options: myOption)
          .then((response) {
        print("==== GET BRAND ==== \n ${response.data}");
        var data = response.data['data'];
        if (response.statusCode == 200) {
          return Brand(
            id: data['id'],
            name: data['name'],
            description: data['description'],
            totalEmployees: data['totalEmployees'],
            startOperation: data['startOperation'],
            category: data['category'],
            image: data['imageId'],
          );
        } else {
          return data;
        }
      });
    } catch (e) {
      print('ERROR BRAND ID = $e');
    }
  }

  updateBrand({
    int? id,
    String? name,
    String? description,
    int? totalEmployees,
    String? startOperation,
    String? category,
    String? image,
  }) async {
    try {
      FormData myData;
      myData = FormData.fromMap({
        "data": jsonEncode({
          "name": name,
          "description": description,
          "totalEmployees": totalEmployees,
          "startOperation": startOperation,
          "category": category,
        })
      });
      return await dio.put("$baseUrl/brands/$id",
          data: myData,
          options: myOption
              .copyWith(headers: {'Content-Type': 'multipart/form-data'}));
    } catch (e) {
      print('ERROR = $e');
    }
  }
}
