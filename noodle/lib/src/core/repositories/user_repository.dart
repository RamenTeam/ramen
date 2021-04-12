import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/schema/queries/get_user.query.dart';
import 'package:noodle/src/core/schema/query_option.dart';

class UserRepository {
  Future<User?> getUser() async {
    GraphQLClient client = await getClient();

    final QueryResult res =
        await client.query(getQueryOptions(schema: getUserQuery, variables: {
      "data": {"userId": "4236768d-aca8-4667-a2df-8f62247a8"}
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return null;
    }

    if (res.isLoading) {
      print("Loading...");
    }

    dynamic userData = res.data['getUser'];

    if (userData == null) return null;

    return User(
        email: userData["email"],
        username: userData["username"],
        id: userData["id"],
        bio: userData["bio"],
        phoneNumber: userData["phoneNumber"]);
  }
}
