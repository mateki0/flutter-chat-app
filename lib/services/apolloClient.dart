import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

ValueNotifier<GraphQLClient> getClient() {
  String? token = '';
  const storage = FlutterSecureStorage();

  Future<String> getPrefs() async {
    String? token = await storage.read(key: 'token');
    if (token == null) {
      return '';
    }

    return token;
  }

  getPrefs().then((value) => token = value);

  // getPrefs().then((value) => print(value));
  const String websocketEndpoint = 'wss://chat.thewidlarzgroup.com/socket';

  final HttpLink httpLink =
      HttpLink('https://chat.thewidlarzgroup.com/api/graphiql');

  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

  Link _link = authLink.concat(httpLink);

  final _wsLink = WebSocketLink(websocketEndpoint,
      config: SocketClientConfig(
          autoReconnect: true,
          inactivityTimeout: const Duration(seconds: 30),
          initialPayload: () async {
            String? token = await storage.read(key: 'token');

            if (token != null) {
              return {
                'headers': {'Authorization': 'Bearer $token'},
              };
            }
          }));

  _link = Link.split((request) => request.isSubscription, _wsLink, _link);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: _link, cache: GraphQLCache(store: HiveStore())));

  return client;
}
