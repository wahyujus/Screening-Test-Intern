import 'package:first_phase/controller/UserController.dart';
import 'package:first_phase/ui/Components.dart';
import 'package:first_phase/ui/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    final userController = Get.put(UserController());

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/bg_validation.png',
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: 'masukkan nama..',
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Components.btn('next', () {
                  if (namaController.text.isEmpty) {
                    EasyLoading.showToast('nama harus di isi',
                        toastPosition: EasyLoadingToastPosition.bottom);
                  } else {
                    Get.to(() => MainMenu());
                    userController.nama.value = namaController.text;
                  }
                })
              ],
            )),
          ),
        ),
      ],
    );
  }
}
