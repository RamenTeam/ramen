import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/schema/mutation_option.dart';
import 'package:noodle/src/core/schema/mutations/login.mutation.dart';
import 'package:noodle/src/core/schema/mutations/logout.mutation.dart';
import 'package:noodle/src/core/schema/mutations/register.mutation.dart';
import 'package:noodle/src/core/schema/mutations/send_connect_request.dart';
import 'package:noodle/src/core/schema/mutations/update_profile.mutation.dart';
import 'package:noodle/src/core/schema/queries/get_user.query.dart';
import 'package:noodle/src/core/schema/queries/me.query.dart';
import 'package:noodle/src/core/schema/query_option.dart';

class UserRepository {
  Future<User?> getUserById(String userId) async {
    GraphQLClient client = getGraphQLClient();

    final QueryResult res =
        await client.query(getQueryOptions(schema: getUserQuery, variables: {
      "data": {"userId": userId}
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

    List<dynamic> connectionsJson = data["connections"];
    print(connectionsJson);
    List<User> connections = connectionsJson
        .map((user) => User(
              id: user['id'],
              username: user['username'],
              name: user['name'],
              avatarPath: user['avatarPath'],
            ))
        .toList();

    User user = User(
      id: data["id"],
      name: data["name"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      username: data["username"],
      email: data["email"],
      phoneNumber: data["phoneNumber"],
      bio: data["bio"],
      avatarPath: data["avatarPath"],
      connections: connections,
    );

    return user;
  }

  Future<User?> getCurrentUser() async {
    GraphQLClient client = getGraphQLClient();

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

    List<dynamic> connectionsJson = data["connections"];
    print(connectionsJson);
    List<User> connections = connectionsJson
        .map((user) => User(
              id: user['id'],
              username: user['username'],
              name: user['name'],
              avatarPath: user['avatarPath'],
            ))
        .toList();

    User user = User(
      id: data["id"],
      name: data["name"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      username: data["username"],
      email: data["email"],
      phoneNumber: data["phoneNumber"],
      bio: data["bio"],
      avatarPath: data["avatarPath"],
      connections: connections,
    );

    PersistentStorage.setUser(user);

    return user;
  }

  Future<ErrorMessage?> updateProfile({
    required String firstName,
    required String lastName,
    required String bio,
    required String avatarPath,
  }) async {
    GraphQLClient client = getGraphQLClient();
    final QueryResult res = await client
        .mutate(getMutationOptions(schema: updateProfileMutation, variables: {
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

    dynamic errJson = res.data['updateProfile'];

    if (errJson == null) return null;
    print(errJson);
    ErrorMessage err = ErrorMessage(
      message: errJson['message'],
      path: errJson['path'],
    );
    return err;
  }

  Future<ErrorMessage?> sendConnectRequest({
    required String id,
  }) async {
    GraphQLClient client = getGraphQLClient();
    final QueryResult res = await client.mutate(
        getMutationOptions(schema: sendConnectRequestMutation, variables: {
      "data": {
        "userId": id,
      }
    }));
    if (res.hasException) {
      print(res.exception.toString());
      return null;
    }

    dynamic errJson = res.data['sendConnectRequest'];

    if (errJson == null) return null;
    print(errJson);
    ErrorMessage err = ErrorMessage(
      message: errJson['message'],
      path: errJson['path'],
    );
    return err;
  }

  Future<ErrorMessage?> register({
    required username,
    required password,
    required email,
    required phoneNumber,
    required firstName,
    required lastName,
  }) async {
    GraphQLClient client = getGraphQLClient();

    final QueryResult res = await client
        .mutate(getMutationOptions(schema: registerMutation, variables: {
      "data": {
        "username": username,
        "password": password,
        "email": email,
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
      },
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return ErrorMessage(
        path: 'flutter_error',
        message: res.exception.toString(),
      );
    }

    if (res.isLoading) {
      print("Loading...");
    }

    dynamic responseData = res.data['register'];

    if (responseData == null) return null;

    return ErrorMessage(
      message: responseData['message'],
      path: responseData['path'],
    );
  }

  Future<ErrorMessage?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    GraphQLClient client = getGraphQLClient();

    final QueryResult res = await client
        .mutate(getMutationOptions(schema: loginMutation, variables: {
      "data": {
        "email": email,
        "password": password,
      },
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return ErrorMessage(
        path: 'flutter_error',
        message: res.exception.toString(),
      );
    }

    dynamic responseData = res.data['login'];

    if (responseData == null) {
      return null;
    }
    ;

    return ErrorMessage(
      message: responseData['message'],
      path: responseData['path'],
    );
  }

  Future<ErrorMessage?> logout() async {
    GraphQLClient client = getGraphQLClient();
    final QueryResult res =
        await client.mutate(getMutationOptions(schema: logoutMutation));

    if (res.hasException) {
      print(res.exception.toString());
      return ErrorMessage(
        path: 'logout',
        message: "unauthenticated",
      );
    }

    dynamic responseData = res.data['logout'];

    if (responseData == null) return null;
  }
}
