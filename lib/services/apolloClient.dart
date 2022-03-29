import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<String> getToken() async {
  String? token = await storage.read(key: 'token');
  if (token == null) {
    return '';
  }

  return token;
}

class GraphQLConfiguration {
  static String token = '';
}

void setToken(String token) {
  GraphQLConfiguration.token = token;
}

String getLoginToken() {
  return GraphQLConfiguration.token;
}

ValueNotifier<GraphQLClient> getClient() {
  HttpLink httpLink = HttpLink('https://chat.thewidlarzgroup.com/api/graphql');

  AuthLink authLink =
      AuthLink(getToken: () async => 'Bearer ${getLoginToken()}');

  Link _link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: _link, cache: GraphQLCache(store: HiveStore())));

  return client;
}
