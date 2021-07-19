import 'package:first_phase/controller/EventController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

class EventMap extends StatefulWidget {
  const EventMap({Key key}) : super(key: key);

  @override
  _EventMapState createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> with TickerProviderStateMixin {
  final eventController = Get.put(EventController());

  static LatLng monumenBambu = LatLng(-7.267775978393605, 112.74440666516759);
  static LatLng monumenSuroBoyo =
      LatLng(-7.295981130412935, 112.73843970028794);
  static LatLng myKost = LatLng(-7.369618445691372, 112.71878616647993);

  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  var listPlaces = [
    {
      'title': 'Event 1',
      'image': 'assets/maps/bambu.jpg',
    },
    {
      'title': 'Event 2',
      'image': 'assets/maps/buaya.jpg',
    },
    {
      'title': 'Event 3',
      'image': 'assets/maps/kosku.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 80.0,
        point: monumenBambu,
        builder: (ctx) => Container(
          color: eventController.indexPressed == 1
              ? Colors.blue
              : Colors.deepOrange,
          key: Key('blue'),
          child: Text(
            'Event 1',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      Marker(
        width: 80.0,
        point: monumenSuroBoyo,
        builder: (ctx) => Container(
          color: eventController.indexPressed == 2
              ? Colors.blue
              : Colors.deepOrange,
          child: Text(
            'Event 2',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      Marker(
        width: 80.0,
        point: myKost,
        builder: (ctx) => Container(
          color: eventController.indexPressed == 3
              ? Colors.blue
              : Colors.deepOrange,
          key: Key('purple'),
          child: Text(
            'Event 3',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      Marker(
        width: 80.0,
        point: LatLng(eventController.lat.value, eventController.long.value),
        builder: (ctx) => Container(
          // color: Colors.deepOrange,
          key: Key('red'),
          child: Text(
            '🧑🏻‍💻',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Animated MapController')),
      body: Stack(
        children: [
          Obx(
            () => FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: LatLng(
                      eventController.lat.value, eventController.long.value),
                  zoom: 12.0,
                  maxZoom: 12.0,
                  minZoom: 3.0),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(markers: markers)
              ],
            ),
          ),
          Container(
              height: 130,
              color: Colors.black26,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: listPlaces.length,
                itemBuilder: (BuildContext context, int index) {
                  var listItem = listPlaces[index];
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          _animatedMapMove(monumenBambu, 12.0);
                          eventController.indexPressed.value = 1;
                          break;
                        case 1:
                          _animatedMapMove(monumenSuroBoyo, 12.0);
                          eventController.indexPressed.value = 2;
                          break;
                        case 2:
                          _animatedMapMove(myKost, 12.0);
                          eventController.indexPressed.value = 3;
                          break;
                        default:
                          _animatedMapMove(monumenBambu, 12.0);
                          eventController.indexPressed.value = 1;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        child: Stack(
                          children: [
                            Image.asset(
                              listItem['image'],
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black45,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(listItem['title']),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 20,
                  );
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animatedMapMove(
              LatLng(eventController.lat.value, eventController.long.value),
              12.0);
        },
        child: Icon(Icons.pin_drop),
      ),
    );
  }
}
