import 'package:chat_app/widgets/header/iconWrapper.dart';
import 'package:chat_app/widgets/screenTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget roomsListHeader(title) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ScreenTitle(title), roomsListButtons()],
          )))));
}

Widget roomsListButtons() {
  const String searchIcon = 'assets/search.svg';
  const String peopleIcon = 'assets/users.svg';

  void onSearchTap() {
    print('search icon tapped');
  }

  void onUsersTap() {
    print('users icon tapped');
  }

  return (Wrap(
    spacing: 8,
    children: [
      iconWrapper(SvgPicture.asset(searchIcon), onSearchTap),
      iconWrapper(SvgPicture.asset(peopleIcon), onUsersTap),
    ],
  ));
}
