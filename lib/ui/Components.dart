import 'package:flutter/material.dart';

class Components {
  static Widget btn(String title, VoidCallback func) {
    return Container(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {
          func();
        },
        child: Text(title),
      ),
    );
  }
}
