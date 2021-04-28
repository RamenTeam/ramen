import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/schema/mutation_option.dart';
import 'package:noodle/src/core/schema/mutations/update_profile.mutation.dart';
import 'package:noodle/src/core/schema/queries/get_user.query.dart';
import 'package:noodle/src/core/schema/queries/me.query.dart';
import 'package:noodle/src/core/schema/query_option.dart';

class UserRepository {
  Future<User?> getUserById(String id) async {
    GraphQLClient client = await getClient();

    final QueryResult res =
        await client.query(getQueryOptions(schema: getUserQuery, variables: {
      "data": {"userId": id}
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return null;
    }

    if (res.isLoading) {
      print("Loading...");
    }

    dynamic data = res.data['getUser'];

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

    return user;
  }

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

  Future<RamenApiResponse?> updateProfile({
    required String firstName,
    required String lastName,
    required String bio,
    required String avatarPath,
  }) async {
    GraphQLClient client = await getClient();
    final QueryResult res = await client.mutate(
        getMutationOptions(schema: getUpdateProfileMutation, variables: {
      "data": {
        "firstName": firstName,
        "lastName": lastName,
        "bio": bio,
        "avatarPath": avatarPath,
      }
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return null;
    }

    if (res.isLoading) {
      print("Loading...");
    }

    dynamic data = res.data['updateProfile'];

    if (data == null) return null;
    print(data);
    RamenApiResponse ramenRes = RamenApiResponse.fromJson(data);
    return ramenRes;
  }
}
