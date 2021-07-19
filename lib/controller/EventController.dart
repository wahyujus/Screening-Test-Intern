import 'package:first_phase/Api/EventRequest.dart';
import 'package:first_phase/controller/UserController.dart';
import 'package:first_phase/models/EventModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  var eventModel = <EventModel>[].obs;

  var lat = 0.0.obs;
  var long = 0.0.obs;

  var indexPressed = 0.obs;

  @override
  void onInit() {
    startUp();
    super.onInit();
  }

  void startUp() async {
    await fetchEvent();
    await getMyLocation();
  }

  Future<void> fetchEvent() async {
    var response = await EventRequest.getEvent();
    if (response != null) {
      eventModel.value = response;
    } else {
      print('cannot fetch');
    }
  }

  Future<void> getMyLocation() async {
    var currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat.value = currentPos.latitude;
    long.value = currentPos.longitude;
  }
}
