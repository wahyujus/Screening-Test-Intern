import 'package:first_phase/Api/GuestRequest.dart';
import 'package:first_phase/models/GuestModel.dart';
import 'package:get/get.dart';

class GuestController extends GetxController {
  var guestModel = <GuestModel>[].obs;

  @override
  void onInit() {
    startUp();
    super.onInit();
  }

  void startUp() async {
    await fetchGuest();
  }

  Future<void> fetchGuest() async {
    var response = await GuestRequest.getGuest();
    if (response != null) {
      guestModel.value = response;
    } else {
      print('cannot fetch');
    }
  }
}
