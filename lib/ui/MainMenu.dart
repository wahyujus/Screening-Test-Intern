import 'dart:io';

import 'package:first_phase/controller/UserController.dart';
import 'package:first_phase/ui/Components.dart';
import 'package:first_phase/ui/Event.dart';
import 'package:first_phase/ui/Guest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(''),
          ),
          body: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => CircleAvatar(
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Nama\t: '),
                        Expanded(
                          child: Text(userController.nama.value),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Components.btn(
                        userController.event.value.isEmpty
                            ? 'pilih event'.toUpperCase()
                            : userController.event.value, () {
                      Get.to(() => Event());
                    }),
                    Components.btn(
                        userController.guest.value.isEmpty
                            ? 'pilih guest'.toUpperCase()
                            : userController.guest.value, () {
                      Get.to(() => Guest());
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
