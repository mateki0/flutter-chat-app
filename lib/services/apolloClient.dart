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

ValueNotifier<GraphQLClient> getClient() {
  String? token = '';

  getToken().then((value) => token = value);

  final HttpLink httpLink =
      HttpLink('https://chat.thewidlarzgroup.com/api/graphql');

  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

  Link _link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: _link, cache: GraphQLCache(store: HiveStore())));

  return client;
}
