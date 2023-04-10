import 'package:dio/dio.dart';

import '../constants/constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String endPoint,
  }) async {
    return await dio!.get(endPoint);
  }

  static Future<Response> postData({
    required String endPoint,
    required FormData data,
  }) async {
    return await dio!.post(endPoint, data: data);
  }
}
