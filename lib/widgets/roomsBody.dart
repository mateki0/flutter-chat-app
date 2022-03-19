import 'package:chat_app/graphql/queries/roomList.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './header.dart';
import './userPhoto.dart';

class RoomsBody extends StatefulWidget {
  const RoomsBody({Key? key}) : super(key: key);

  @override
  _RoomsBodyState createState() => _RoomsBodyState();
}

class _RoomsBodyState extends State<RoomsBody> {
  @override
  Widget build(BuildContext) {
    return Query(
        options: QueryOptions(document: gql(roomList)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Text('Loading');
          }

          // if (result.hasException) {
          //   return Text(result.exception.toString());
          // }

          print(result.data);

          // if (result.data != null) {
          //   List rooms = result.data?['room'];
          //   ListView.builder(itemBuilder: (context, index) {
          //     return ListTile(title: rooms[index]);
          //   });
          // }

          // return Container();
          // return ListView.builder(itemBuilder: (context, index) {
          //   return SafeArea(
          //       child: Column(
          //           children: [singleRoom(false, 'roomName', 'something')]));
          // });
          return SafeArea(
            child: Column(
              children: [
                Header('Rooms'),
                roomsList(),
              ],
            ),
          );
        });
  }
}

Widget roomsList() {
  return (Expanded(
      child: ListView(
    padding: const EdgeInsets.only(top: 30.0),
    children: [
      singleRoom(false, "The one with Harry", "Hey Harry, how you doing?"),
      singleRoom(true, "The one with Ron", "Ron sent a photo.")
    ],
  )));
}

Widget singleRoom(bool? isNewMessage, String roomName, String lastMessage) {
  return (SizedBox(
    height: 100,
    child: Container(
      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: isNewMessage == true ? const Color(0xff5603AD) : Colors.white,
      ),
      child: Row(children: [
        UserPhoto(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6.0, left: 16.0),
              child: Text(roomName,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color:
                          isNewMessage == true ? Colors.white : Colors.black)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6.0, left: 16.0),
              child: Text(lastMessage,
                  style: TextStyle(
                      fontSize: 14,
                      color:
                          isNewMessage == true ? Colors.white : Colors.black)),
            ),
          ],
        )
      ]),
    ),
  ));
}
