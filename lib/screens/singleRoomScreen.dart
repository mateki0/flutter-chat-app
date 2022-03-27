import 'package:flutter/material.dart';
import '../widgets/chatBody.dart';

class SingleRoomScreen extends StatelessWidget {
  const SingleRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xffF0F8FF),
      body: ChatBody(messages: data['messages']),
    );
  }
}
