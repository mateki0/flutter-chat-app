import 'package:chat_app/services/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './screens/login.dart';
import './services/apolloClient.dart';
import './screens/rooms.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'screens/singleRoomScreen.dart';

const storage = FlutterSecureStorage();

Future<void> main() async {
  await initHiveForFlutter();

  getToken().then((token) {
    if (token.isEmpty) {
      runApp(const MyApp(page: '/login', token: ''));
    } else {
      runApp(MyApp(page: '/rooms', token: token));
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.page, required this.token})
      : super(key: key);

  final String page;
  final String token;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => User(),
        )
      ],
      child: GraphQLProvider(
        client: getClient(token),
        child: MaterialApp(
          initialRoute: page,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/rooms': (context) => const RoomsScreen(),
            '/singleRoom': (context) => const SingleRoomScreen(),
          },
        ),
      ),
    );
  }
}
