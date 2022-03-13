import 'package:flutter/material.dart';

Widget InputWithLabel(label, hintText, controller, key, validator) {
  return (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        key: Key(key),
        obscureText: true,
        validator: (value) => validator(value, key),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(8.0),
        ),
        controller: controller,
      ),
    ),
  ]));
}
