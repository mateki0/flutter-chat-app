import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './screens/login.dart';
import './services/apolloClient.dart';
import './screens/rooms.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<void> main() async {
  await initHiveForFlutter();

  getToken().then((token) {
    if (token.isEmpty) {
      runApp(const MyApp(page: '/login'));
    } else {
      runApp(const MyApp(page: '/rooms'));
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.page}) : super(key: key);

  final String page;
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: getClient(),
      child: MaterialApp(
        initialRoute: page,
        routes: {
          '/login': (context) => const LoginScreen(),
          '/rooms': (context) => const RoomsScreen(),
          // '/room:id': (context) => Room(id)
        },
      ),
    );
  }
}
