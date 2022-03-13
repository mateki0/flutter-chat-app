import 'package:flutter/material.dart';
import '../widgets/roomsBody.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms list'),
      ),
      body: const RoomsBody(),
    );
  }
}
