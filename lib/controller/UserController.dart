import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserController extends GetxController {
  var nama = ''.obs;
  var event = ''.obs;
  var guest = ''.obs;

  var myImg = ''.obs;

  static DateFormat dateFormatter = DateFormat('d MMM yyyy');

  Future<void> changeImg(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker.pickImage(source: imageSource, imageQuality: 50);

    myImg.value = pickedFile.path;
  }
}
