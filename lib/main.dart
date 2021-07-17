import 'package:first_phase/ui/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Phase',
      theme: ThemeData.dark(),
      home: Home(),
      builder: EasyLoading.init(),
    );
  }
}
