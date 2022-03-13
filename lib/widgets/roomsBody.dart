import 'package:chat_app/graphql/queries/roomList.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Text('Loading');
          }

          print(result.data);

          // if (result != null) {
          //   List rooms = result.data?.['room'];
          // }
          // return ListView.builder(itemBuilder: (context, index){
          //   return Text(rooms\[index]\['name']);
          // });
          return Column(
            children: [if (result.data != null) const Text('gowno')],
          );
        });
  }
}

// class RoomsList extends StatelessWidget {
//   const RoomsList({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//    return Query(
//         options: QueryOptions(document: gql(roomList)),
//         builder: (QueryResult result, {VoidCallback refetch}) {
//           if (result.hasException) {
//             return Text(result.exception.toString());
//           }
//           if (result.isLoading) {
//             return Text('Loading');
//           }
//           print(result.data);

//           List rooms = result.data('room');

//           return ListView.builder(itemBuilder: (context, index){
//             return Text(rooms\[index]\['name']);
//           })
//         });
//   }
// }