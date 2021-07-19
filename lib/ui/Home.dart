import 'dart:io';

import 'package:first_phase/controller/UserController.dart';
import 'package:first_phase/ui/Components.dart';
import 'package:first_phase/ui/MainMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController namaController = TextEditingController();
  final userController = Get.put(UserController());

  bool isPanlindrome(String word) {
    for (int i = 0; i < word.length ~/ 2; i++) {
      if (word[i] != word[word.length - i - 1]) return false;
    }
    return true;
  }

  void changeImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF202125),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await userController.changeImg(ImageSource.camera);
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Camera')
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await userController.changeImg(ImageSource.gallery);
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(Icons.image),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Gallery')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/bg_validation.png',
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Selamat Datang!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Sertakan gambar profil Anda untuk melengkapi profil',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      changeImage();
                    },
                    child: Obx(() => CircleAvatar(
                        maxRadius: 70,
                        backgroundColor: Colors.white30,
                        child: userController.myImg.isEmpty
                            ? Icon(
                                Icons.person_add,
                                size: 50,
                                color: Colors.white,
                              )
                            : null,
                        backgroundImage: userController.myImg.isEmpty
                            ? null
                            : Image.file(File(userController.myImg.value))
                                .image)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Sarah Vidyarani',
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      if (namaController.text.isEmpty) {
                        EasyLoading.showToast('nama harus di isi',
                            toastPosition: EasyLoadingToastPosition.bottom);
                      } else {
                        Get.to(() => MainMenu());
                        userController.nama.value = namaController.text;
                        EasyLoading.showInfo(isPanlindrome(namaController.text)
                            ? 'isPalindrome'
                            : 'not palindrome');
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Selesai',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                  // Components.btn('next', () {
                  //   if (namaController.text.isEmpty) {
                  //     EasyLoading.showToast('nama harus di isi',
                  //         toastPosition: EasyLoadingToastPosition.bottom);
                  //   } else {
                  //     Get.to(() => MainMenu());
                  //     userController.nama.value = namaController.text;
                  //     EasyLoading.showInfo(isPanlindrome(namaController.text)
                  //         ? 'isPalindrome'
                  //         : 'not palindrome');
                  //   }
                  // })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
