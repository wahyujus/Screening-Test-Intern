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
              // Get.to(() => EventMap());
            },
            icon: Icon(Icons.search),
          ),
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
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listItem.name ?? '-'),
                        Text(
                          UserController.dateFormatter.format(listItem.date),
                          style: TextStyle(color: Colors.yellow),
                        ),
                        index.isOdd
                            ? Container(
                                color: Colors.blueGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('Lorem Ipsum'),
                                ),
                              )
                            : Row(
                                children: [
                                  Container(
                                    color: Colors.blueGrey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('Lorem Ipsum'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    color: Colors.blueGrey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('Lorem Ipsum'),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          'Ullamco qui qui consequat dolore sint dolor quis ipsum ea commodo qui tempor non.'),
                    ),
                    trailing: CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: Image.network(
                        listItem.image ?? '',
                        fit: BoxFit.fitHeight,
                      ).image,
                    ),
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
