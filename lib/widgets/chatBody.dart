import 'package:chat_app/graphql/queries/currentUser.dart';
import 'package:chat_app/services/userProvider.dart';
import 'package:chat_app/widgets/header/singleRoomHeader.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../view_models/loadingAnimation.dart';

class ChatBody extends StatefulWidget {
  final List<ChatMessage> messages;
  final String roomName;

  const ChatBody({
    Key? key,
    required this.messages,
    required this.roomName,
  }) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        singleRoomHeader(widget.roomName, context),
        Chat(messages: widget.messages)
      ],
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
    return Query(
        options: QueryOptions(document: gql(currentUser)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Expanded(child: CustomLoader());
          }
          if (result.data == null) return const Text('Error');

          var user = context.read<User>();

          String firstName = result.data?['user']?['firstName'];
          String id = result.data?['user']?['id'];

          final ChatUser currentUser = ChatUser(
            firstName: firstName,
            id: id,
          );

          user.updateUser(firstName, id);

          if (widget.messages.isEmpty) {
            return Container();
          } else {
            m = widget.messages;
            return Expanded(
                child: DashChat(
                    messages: m, currentUser: currentUser, onSend: onSend));
          }
        });
  }
}
