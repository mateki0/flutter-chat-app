import 'package:chat_app/widgets/header/iconWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget singleRoomHeader(title, context) {
  const String arrowLeftIcon = 'assets/arrow-left.svg';
  const String chatImage = 'assets/chat-placeholder.png';

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
            children: [
              Row(
                children: [
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: SvgPicture.asset(arrowLeftIcon),
                      ),
                      onTap: () => Navigator.pop(context)),
                  Container(
                    margin: const EdgeInsets.only(left: 13.0, right: 12.0),
                    child: Image.asset(chatImage),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      roomName(title),
                      activeNow(),
                    ],
                  )
                ],
              ),
              Row(
                children: [singleRoomButtons()],
              )
            ],
          )))));
}

Widget singleRoomButtons() {
  const String phoneIcon = 'assets/phone.svg';
  const String cameraIcon = 'assets/camera.svg';

  void onPhoneTap() {
    print('phone icon tapped');
  }

  void onCameraTap() {
    print('camera icon tapped');
  }

  return (Wrap(
    spacing: 8,
    children: [
      iconWrapper(SvgPicture.asset(phoneIcon), onPhoneTap),
      iconWrapper(SvgPicture.asset(cameraIcon), onCameraTap),
    ],
  ));
}

Widget roomName(String title) {
  return (Container(
      constraints: const BoxConstraints(maxWidth: 140),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xff5603AD),
            height: 1.5),
      )));
}

Widget activeNow() {
  return (Container(
      margin: const EdgeInsets.only(top: 2.0),
      child: const Text(
        'Active now',
        style: TextStyle(color: Color(0xffffffff), fontSize: 14),
      )));
}
