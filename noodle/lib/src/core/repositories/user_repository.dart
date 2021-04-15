import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';
import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/schema/queries/me.query.dart';
import 'package:noodle/src/core/schema/query_option.dart';

class UserRepository {
  Future<User?> getUser() async {
    GraphQLClient client = await getClient();

    final QueryResult res =
        await client.query(getQueryOptions(schema: meQuery));

    if (res.hasException) {
      print(res.exception.toString());
      return null;
    }

    if (res.isLoading) {
      print("Loading...");
    }

    dynamic data = res.data['me'];

    if (data == null) return null;

    User user = User(
      email: data["email"],
      username: data["username"],
      id: data["id"],
      bio: data["bio"],
      phoneNumber: data["phoneNumber"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      avatarPath: data["avatarPath"],
    );

    PersistentStorage.setUser(user);

    return user;
  }
}
