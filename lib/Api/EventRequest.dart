import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:first_phase/models/EventModel.dart';

import 'RestService.dart';

class EventRequest {
  static Future<List<EventModel>> getEvent() async {
    RestService.dio.interceptors.add(RestService.dioCacheManager.interceptor);

    RestService.response = await RestService.dio.get(
      RestService.baseUrl + 'v3/91da6bf0-37e8-44e3-bfa2-5881054a37ee',
      options: RestService.cacheOptions,
    );
    if (RestService.response.statusCode == 200) {
      var jsonString = json.encode(RestService.response.data);
      print(jsonString.toString());
      return eventModelFromJson(jsonString);
    } else {
      return <EventModel>[];
    }
  }
}
