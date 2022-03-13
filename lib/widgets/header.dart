import 'package:chat_app/widgets/screenTitle.dart';
import 'package:flutter/material.dart';

Widget Header(title) {
  return (SizedBox(
      height: 120,
      child: (Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: const BoxDecoration(
              color: Color(0xffB6DEFD),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0))),
          child: Row(
            children: [ScreenTitle(title)],
          )))));
}
