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
      print('ERROR = $e');
    }
  }

  getBrandById({required id}) async {
    try {
      return await dio.get(
          "$baseUrl/brands/$id?sort=createdAt&direction=desc&populate=Upload",
          options: myOption);
    } catch (e) {
      print('ERROR = $e');
    }
  }

  Future<void> updateBrand({
    int? id,
    String? name,
    String? description,
    int? totalEmployees,
    String? startOperation,
    String? category,
    String? image,
  }) async {
    try {} catch (e) {}
  }
}
