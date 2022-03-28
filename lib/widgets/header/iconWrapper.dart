import 'package:flutter/material.dart';

Widget iconWrapper(child, onTap) {
  return (SizedBox(
    child: GestureDetector(
      child: Container(
        child: child,
        alignment: const Alignment(0.0, 0.1),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(22.0),
        ),
      ),
      onTap: onTap,
    ),
    width: 44,
    height: 44,
  ));
}
