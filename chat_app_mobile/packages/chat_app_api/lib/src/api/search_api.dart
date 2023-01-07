import 'package:dio/dio.dart';

import '../models/models.dart';

class SearchApi {
  SearchApi({Dio? dio, required String serverUrl})
      : _dio = dio ?? Dio(),
        _serverUrl = serverUrl;

  final String _serverUrl;

  String get basePath => '$_serverUrl/search';

  final Dio _dio;

  Future<Search> getSearch(String bearerToken, String input) async {
    final url = '$basePath?q=$input';

    final response = await _dio.get(url,
        options: Options(headers: {"authorization": 'Bearer $bearerToken'}));
    final searchJson = response.data as dynamic;

    final listSearch = Search.fromJson(searchJson);

    return listSearch;
  }
}
