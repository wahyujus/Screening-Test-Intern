import 'package:first_phase/Api/EventRequest.dart';
import 'package:first_phase/controller/UserController.dart';
import 'package:first_phase/models/EventModel.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  var eventModel = <EventModel>[].obs;

  @override
  void onInit() {
    startUp();
    super.onInit();
  }

  void startUp() async {
    await fetchEvent();
  }

  Future<void> fetchEvent() async {
    var response = await EventRequest.getEvent();
    if (response != null) {
      eventModel.value = response;
    } else {
      print('cannot fetch');
    }
  }
}
