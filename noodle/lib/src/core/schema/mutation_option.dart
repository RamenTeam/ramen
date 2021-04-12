// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';

MutationOptions getMutationOptions({required String schema, dynamic variables}) {
  return MutationOptions(document: gql(schema), variables: variables);
}