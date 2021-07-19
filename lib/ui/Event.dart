import 'package:first_phase/controller/EventController.dart';
import 'package:first_phase/controller/UserController.dart';
import 'package:first_phase/ui/EventMap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Event extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final eventController = Get.put(EventController());

    return Scaffold(
      appBar: AppBar(
        title: Text('EVENT'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EventMap());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () => eventController.eventModel.value.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: eventController.eventModel.value.length,
                itemBuilder: (BuildContext context, int index) {
                  var listItem = eventController.eventModel.value[index];
                  return ListTile(
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: Image.network(
                        listItem.image ?? '',
                        fit: BoxFit.fitHeight,
                      ).image,
                    ),
                    title: Text(listItem.name ?? '-'),
                    subtitle: Text(
                        UserController.dateFormatter.format(listItem.date)),
                    trailing: Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      Get.back();
                      userController.event.value = listItem.name;
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 2,
                  );
                },
              ),
      ),
    );
  }
}
