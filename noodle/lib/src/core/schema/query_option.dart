// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';

QueryOptions getQueryOptions({required String schema, dynamic variables}) {
  return QueryOptions(document: gql(schema), variables: variables);
}
