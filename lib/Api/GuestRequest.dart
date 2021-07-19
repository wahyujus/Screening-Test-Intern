import 'dart:convert';

import 'package:first_phase/models/GuestModel.dart';

import 'RestService.dart';

class GuestRequest {
  static Future<List<GuestModel>> getGuest() async {
    RestService.dio.interceptors.add(RestService.dioCacheManager.interceptor);

    RestService.response = await RestService.dio.get(
      RestService.baseUrl + 'v2/596dec7f0f000023032b8017',
      options: RestService.cacheOptions,
    );
    if (RestService.response.statusCode == 200) {
      var jsonString = json.encode(RestService.response.data);
      print(jsonString.toString());
      return guestModelFromJson(jsonString);
    } else {
      return <GuestModel>[];
    }
  }
}
