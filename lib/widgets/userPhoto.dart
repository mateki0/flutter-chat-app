import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget UserPhoto() {
  const String assetName = 'assets/photo-placeholder.svg';

  return (SizedBox(
      width: 64,
      height: 64,
      child: Container(
        alignment: const Alignment(0.0, 1.0),
        child: SvgPicture.asset(assetName),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: const Color(0xffE9EAEE),
            borderRadius: BorderRadius.circular(32.0)),
      )));
}
