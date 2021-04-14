// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql_flutter/graphql_flutter.dart';

final _httpLink = HttpLink(
  'https://ramen-server.herokuapp.com',
);

Link _link = _httpLink;

Future<GraphQLClient> getClient() async {
  /// initialize Hive and wrap the default box in a HiveStore
  return GraphQLClient(
    /// pass the store to the cache for persistence
    cache: GraphQLCache(),
    link: _link,
  );
}
