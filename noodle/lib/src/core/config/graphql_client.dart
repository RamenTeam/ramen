// ignore: import_of_legacy_library_into_null_safe
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

final String productionEndpoint = 'https://ramen-server.herokuapp.com';
final String developmentEndpoint = "http://192.168.1.105:5000";

final dio = Dio();
final cookieJar = CookieJar(
  ignoreExpires: false,
);
// ignore: non_constant_identifier_names

final Link _dioLink = DioLink(
  productionEndpoint,
  client: dio,
);

void getCookieFromApp() async {
  var res = await http.get(Uri.parse(productionEndpoint + "/get-cookie"));

  print(res.body);
}

Future<GraphQLClient> getClient() async {
  dio.interceptors.add(CookieManager(cookieJar));

  GraphQLClient client = GraphQLClient(
    /// pass the store to the cache for persistence
    cache: GraphQLCache(),
    link: _dioLink,
  );

  return client;
}
