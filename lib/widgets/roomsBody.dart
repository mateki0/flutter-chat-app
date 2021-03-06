import 'package:chat_app/graphql/queries/roomList.dart';
import 'package:chat_app/graphql/queries/singleRoom.dart';
import 'package:chat_app/screens/singleRoomScreen.dart';
import 'package:chat_app/view_models/loadingAnimation.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'header/roomsListHeader.dart';
import './userPhoto.dart';

class RoomsBody extends StatefulWidget {
  const RoomsBody({Key? key}) : super(key: key);

  @override
  _RoomsBodyState createState() => _RoomsBodyState();
}

bool loading = true;

class _RoomsBodyState extends State<RoomsBody> {
  delayedAnimation() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    delayedAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(roomList)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading || loading) {
            return const CustomLoader();
          }

          List rooms = result.data?['usersRooms']?['rooms'] ?? [];

          return SafeArea(
              child: Column(
            children: [
              roomsListHeader('Rooms', context),
              Expanded(
                  child: rooms.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 30.0),
                          shrinkWrap: true,
                          itemCount: rooms.length,
                          itemBuilder: (context, index) {
                            final room = rooms[index];

                            return SingleRoom(roomId: room['id']);
                          })
                      : const CustomLoader())
            ],
          ));
        });
  }
}

class SingleRoom extends StatelessWidget {
  const SingleRoom({Key? key, required this.roomId}) : super(key: key);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Query(
        options:
            QueryOptions(document: gql(singleRoom), variables: {'id': roomId}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.data == null) return Container();
          if (result.isLoading) return Container();

          final lastMessage = result.data?['room']?['messages'][0];

          List messages = result.data?['room']?['messages'];
          var userFromResponse = result.data?['room']?['user'];

          ChatUser user = ChatUser(
            id: userFromResponse['id'],
            firstName: userFromResponse['firstName'],
            lastName: userFromResponse['lastName'],
          );

          List<ChatMessage> chatMessages = messages
              .map((a) => ChatMessage.new(
                  text: a["body"],
                  createdAt: DateTime.parse(a['insertedAt']),
                  user: user))
              .toList();

          return room(false, result.data?['room']?['name'], lastMessage['body'],
              result.data?['room']?['id'], chatMessages, context);
        });
  }
}

Widget room(bool? isNewMessage, String roomName, String lastMessage,
    String roomId, List<ChatMessage> messages, BuildContext context) {
  return (InkWell(
      splashColor: const Color(0xff993AFC),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SingleRoomScreen(),
                settings: RouteSettings(arguments: {
                  'roomId': roomId,
                  'roomName': roomName,
                  'messages': messages
                })));
      },
      child: SizedBox(
          height: 100,
          child: Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color:
                  isNewMessage == true ? const Color(0xff5603AD) : Colors.white,
            ),
            child: Row(children: [
              UserPhoto(),
              roomTexts(roomName, isNewMessage, lastMessage)
            ]),
          ))));
}

Widget roomTexts(String roomName, bool? isNewMessage, String lastMessage) {
  return (Expanded(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 6.0, left: 16.0),
        child: Text(roomName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: isNewMessage == true ? Colors.white : Colors.black)),
      ),
      Container(
        margin: const EdgeInsets.only(top: 6.0, left: 16.0),
        child: Text(lastMessage,
            style: TextStyle(
                fontSize: 14,
                color: isNewMessage == true ? Colors.white : Colors.black)),
      ),
    ],
  )));
}
