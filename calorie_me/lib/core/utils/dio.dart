import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../constants/constants.dart';
import 'dart:io';

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

    final httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    (dio?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client = httpClient;
      client.connectionTimeout = const Duration(seconds: 60);
      client.idleTimeout = const Duration(seconds: 60);
      return client;
    };
  }

  static Future<Response> getData({
    required String endPoint,
  }) async {
    return await dio!.get(endPoint);
  }

  static Future<Response> postData({
    required String endPoint,
    required FormData data,
    required CancelToken cancelToken,
  }) async {
    return await dio!.post(endPoint, data: data, cancelToken: cancelToken);
  }
}
