import 'package:chat_app/widgets/header/iconWrapper.dart';
import 'package:chat_app/widgets/screenTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/userProvider.dart';

Widget roomsListHeader(String title, BuildContext context) {
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
            children: [ScreenTitle(title), roomsListButtons(context)],
          )))));
}

Widget roomsListButtons(context) {
  const String searchIcon = 'assets/search.svg';
  const String peopleIcon = 'assets/users.svg';

  void onSearchTap() {
    print('search icon tapped');
  }

  void onUsersTap() {
    print('users icon tapped');
  }

  void onLogoutTap() async {
    const storage = FlutterSecureStorage();
    var user = context.read<User>();

    user.updateUser('', '');
    await storage.write(key: 'token', value: '');
    Navigator.pushNamed(context, '/login');
  }

  return (Wrap(
    spacing: 8,
    children: [
      iconWrapper(SvgPicture.asset(searchIcon), onSearchTap),
      iconWrapper(SvgPicture.asset(peopleIcon), onUsersTap),
      iconWrapper(
          const Icon(Icons.logout, color: Color(0xff5603AD)), onLogoutTap),
    ],
  ));
}
