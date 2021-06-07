import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/config/application.dart';

class API {
  static String baseUrl = "http://192.168.31.170:9000";

  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      sendTimeout: 60000,
      receiveTimeout: 30000,
      contentType: 'application/json; charset=utf-8',
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ),
  );

  API() {
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    // dio.interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          Application.sharePreference.hasKey("authToken")
              ? options.headers["Authorization"] = "Bearer ${Application.sharePreference.getString("authToken")}"
              : {};
          print(options.uri);
          return handler.next(options); //continue
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) async {
          return handler.next(response); // continue
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          handleTimeOutException(e.type);
          // Refresh Token
          Modular.to.pushReplacementNamed(AppModule.login);
          print(e);
          return handler.resolve(e.response!); //continue
        },
      ),
    );
  }

  void handleTimeOutException(DioErrorType type) {
    switch (type) {
      case DioErrorType.connectTimeout:
        Application.toast.showToastFailed("Failed connect to server");
        break;
      case DioErrorType.sendTimeout:
        Application.toast.showToastFailed("Failed sending data to server");
        break;
      case DioErrorType.receiveTimeout:
        Application.toast.showToastFailed("Failed receiving data from server");
        break;
      default:
        break;
    }
  }

  Future get(String url, [Map<String, dynamic>? params]) async {
    return dio.get(url, queryParameters: params);
  }

  Future post(String url, Map<String, dynamic>? params) async {
    return dio.post(url, data: params);
  }

  Future put(String url, [Map<String, dynamic>? params]) async {
    return dio.put(url, data: params);
  }

  Future delete(String url, [Map<String, dynamic>? params]) async {
    return dio.delete(url, queryParameters: params);
  }
}
