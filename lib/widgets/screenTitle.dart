import 'package:flutter/material.dart';

Widget ScreenTitle(title) {
  return (Padding(
    padding: const EdgeInsets.symmetric(vertical: 24.0),
    child: Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w500, color: Color(0xff5603AD), fontSize: 28),
    ),
  ));
}
