import 'package:chat_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatBody extends StatefulWidget {
  final List<ChatMessage> messages;

  const ChatBody({Key? key, required this.messages}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [Header('The widlarz group'), Chat(messages: widget.messages)],
    ));
  }
}

class Chat extends StatefulWidget {
  final List<ChatMessage> messages;

  const Chat({Key? key, required this.messages}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatUser otherUser = ChatUser(
    firstName: 'secondUser',
    id: '213213',
  );

  List<ChatMessage> m = [];

  var i = 0;

  @override
  void initState() {
    super.initState();
  }

  void onSend(ChatMessage message) {
    setState(() {
      m.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.messages.isEmpty) {
      return Container();
    } else {
      m = widget.messages;
      return Expanded(
          child: DashChat(messages: m, currentUser: otherUser, onSend: onSend));
    }
  }
}
