import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  var nama = ''.obs;
  var event = ''.obs;
  var guest = ''.obs;

  static DateFormat dateFormatter = DateFormat('d MMM yyyy');
}
