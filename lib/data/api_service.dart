import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:rick_and_morty_wiki/data/sources/api_const_urls.dart';

mixin ApiService<T extends Object> {
  abstract String apiRoute;

  final _dio =
      Dio()
        ..interceptors.add(
          DioCacheInterceptor(
            options: CacheOptions(
              store: MemCacheStore(),
              policy: CachePolicy.forceCache,
              maxStale: const Duration(days: 7),
              priority: CachePriority.high,
            ),
          ),
        );

  BaseOptions getOptions({Map<String, dynamic>? params}) => BaseOptions(
    headers: {'Accept': 'application/json'},
    queryParameters: params,
  );

  //Метод для получения списка айтемов
  Future<List<T>> getList({
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? params,
    dynamic id,
  }) async {
    final response = await _dio.get(
      '${ApiConstUrl.baseUrl}$apiRoute/${id ?? ''}',
      queryParameters: params,
      options: Options(extra: {'refresh': false}),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.data);
    }

    final jsonList = response.data['results'] as List<dynamic>;
    return jsonList.map((e) => fromJson(e)).toList();
  }

  //Метод для получения одного айтема
  Future<T> get({
    required T Function(Map<String, dynamic>) fromJson,
    int? id,
  }) async {
    final dio = Dio(getOptions());

    final response = await dio.get(
      '${ApiConstUrl.baseUrl}$apiRoute/${id ?? ''}]',
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.data);
    }

    final jsonList = response.data;
    return fromJson(jsonList);
  }
}
