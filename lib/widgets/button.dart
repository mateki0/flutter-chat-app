import 'package:flutter/material.dart';

Widget button(onSubmit) {
  return ElevatedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(48.0)),
          backgroundColor: MaterialStateProperty.all(const Color(0xff5603AD)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)))),
      onPressed: onSubmit,
      child: const Text(
        'Submit',
      ));
}
