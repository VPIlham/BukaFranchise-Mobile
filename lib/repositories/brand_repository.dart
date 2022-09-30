import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:bukafranchise/utils/constant.dart';
import 'package:http_parser/http_parser.dart';

class BrandRepository {
  var dio = Dio();

  var myOption = Options(
      followRedirects: false,
      validateStatus: (status) => true,
      headers: {"Content-Type": "application/json"});

  getAllBrand({String? search, int? pageSize = 7}) async {
    try {
      dio.options.queryParameters.clear();

      if (search != null) {
        dio.options.queryParameters.addAll({
          "q": search,
        });
      }

      if (pageSize != null) {
        dio.options.queryParameters.addAll({
          "pageSize": pageSize,
        });
      }

      return await dio.get(
          "$baseUrl/brands?sort=createdAt&direction=desc&populate=Upload",
          options: myOption);
    } catch (e) {
      print('ERROR = $e');
    }
  }

  getAllBrandItems({String? search, int? pageSize = 7}) async {
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

  getBrandById({required id}) async {
    try {
      final token = await getToken();
      return await dio.get(
        "$baseUrl/brands/$id?populate=User,Item.Upload,Upload",
        options: myOption.copyWith(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
    } catch (e) {
      print('ERROR = $e');
    }
  }

  updateBrand({required id, data, image}) async {
    try {
      FormData myData;

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
        "$baseUrl/brands/$id",
        data: myData,
        options: myOption.copyWith(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );
    } catch (e) {
      print('ERROR = $e');
    }
  }

  postWishlist({required id}) async {
    try {
      final token = await getToken();
      return await dio.post(
        "$baseUrl/wishlist/$id/post",
        options: myOption.copyWith(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
    } catch (e) {
      print('ERROR Wishlist = $e');
    }
  }

  removeWishlist({required id}) async {
    try {
      final token = await getToken();
      return await dio.delete(
        "$baseUrl/wishlist/$id/remove",
        options: myOption.copyWith(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
    } catch (e) {
      print('ERROR Wishlist = $e');
    }
  }
}
