import 'package:dio/dio.dart';

import '../../constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      // headers: {
      //   'Content-Type': 'application/json',
      // },
      // receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String endPoint,
    String? token,
  }) async {
    // dio!.options.headers = {
    //   'authorization': 'Bearer $token',
    // };
    return await dio!.get(endPoint,);
  }

  static Future<Response> postData({
    required String endPoint,
    required FormData data,
    String? token,
  }) async {
    // dio!.options.headers={
    //   'authorization' : 'Bearer $token',
    // };
    // dio!.options.headers = {
    //   'Content-Type': 'application/json',
    //   'Connection': 'keep-alive',
    //   'Accept': '*/*',
    // };
    return await dio!.post(endPoint, data: data);
  }
}
