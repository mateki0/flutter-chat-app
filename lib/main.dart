import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './screens/login.dart';
import './services/apolloClient.dart';
import './screens/rooms.dart';

Future<void> main() async {
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: getClient(),
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffB6DEFD)),
        routes: {
          '/': (context) => const LoginScreen(),
          '/rooms': (context) => const RoomsScreen(),
          // '/room:id': (context) => Room(id)
        },
      ),
    );
  }
}
