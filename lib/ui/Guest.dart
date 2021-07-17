import 'package:first_phase/controller/EventController.dart';
import 'package:first_phase/controller/GuestController.dart';
import 'package:first_phase/controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Guest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final guestController = Get.put(GuestController());

    return Scaffold(
      appBar: AppBar(
        title: Text('GUEST'),
        centerTitle: true,
      ),
      body: Obx(
        () => guestController.guestModel.value.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: guestController.guestModel.value.length,
                itemBuilder: (BuildContext context, int index) {
                  var listItem = guestController.guestModel.value[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        userController.guest.value = listItem.name!;
                        EasyLoading.showToast(
                            listItem.birthdate!.day % 2 == 0 &&
                                    listItem.birthdate!.day % 3 == 0
                                ? 'IOS'
                                : listItem.birthdate!.day % 2 == 0
                                    ? 'blackberry'
                                    : listItem.birthdate!.day % 3 == 0
                                        ? 'android'
                                        : 'feature phone',
                            toastPosition: EasyLoadingToastPosition.bottom);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(listItem.name ?? '-'),
                            Text(
                              UserController.dateFormatter
                                  .format(listItem.birthdate!),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
