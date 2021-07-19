import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class RestService {
  static Response response;
  static Dio dio = Dio();
  static String baseUrl = 'https://run.mocky.io/';
  static DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  static Options cacheOptions =
      buildCacheOptions(Duration(days: 7), forceRefresh: true);
}
