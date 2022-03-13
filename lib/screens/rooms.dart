import 'package:flutter/material.dart';
import '../widgets/roomsBody.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF0F8FF),
      body: RoomsBody(),
    );
  }
}
