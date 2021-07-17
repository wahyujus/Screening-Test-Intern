import 'package:dio/dio.dart';

class RestService {
  static Response? response;
  static var dio = Dio();
  static String baseUrl = 'https://run.mocky.io/';
}
