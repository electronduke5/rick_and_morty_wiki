import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_wiki/data/sources/api_const_urls.dart';

mixin ApiService<T extends Object> {
  abstract String apiRoute;

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
    final dio = Dio(getOptions(params: params));
    final response = await dio.get(
      '${ApiConstUrl.baseUrl}$apiRoute/${id ?? ''}',
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
