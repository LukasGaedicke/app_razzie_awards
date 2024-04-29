import 'dart:async';

import 'package:dio/dio.dart' as extenal_dio;

import 'options.dart';
import 'response.dart';

abstract class AppHttpClient {
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<Response<List<T>>> getAsList<T>(
    String path, {
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, dynamic>? queryParameters,
  });
}

final class AppHttpClientImpl implements AppHttpClient {
  AppHttpClientImpl({
    required this.options,
    extenal_dio.Dio? dio,
  }) : _dio = dio ??
            extenal_dio.Dio(
              extenal_dio.BaseOptions(
                baseUrl: options.baseUrl.endsWith('/')
                    ? options.baseUrl
                    : '${options.baseUrl}/',
                connectTimeout: options.connectTimeout,
                sendTimeout: options.sendTimeout,
                receiveTimeout: options.receiveTimeout,
              ),
            );

  final extenal_dio.Dio _dio;
  final ClientOptions options;

  Future<extenal_dio.Response<String>> _getInternal(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio
          .get<String>(path, queryParameters: queryParameters)
          .timeout(options.globalTimeout);
      return response;
    } on extenal_dio.DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async =>
      Response<T>.fromDioResponse(
        await _getInternal(
          path,
          queryParameters: queryParameters,
        ),
        fromJson: fromJson,
      );

  @override
  Future<Response<List<T>>> getAsList<T>(
    String path, {
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async =>
      Response.fromDioResponseAsList<T>(
        await _getInternal(
          path,
          queryParameters: queryParameters,
        ),
        fromJson: fromJson,
      );

  void addInterceptor() {
    _dio.interceptors.add(
      extenal_dio.LogInterceptor(
        requestBody: true, // Log do corpo da solicitação
        responseBody: true, // Log do corpo da resposta
        error: true, // Log de erros
      ),
    );
  }
}
