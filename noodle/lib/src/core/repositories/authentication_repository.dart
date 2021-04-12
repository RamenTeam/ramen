import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:noodle/src/constants/api_endpoint.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/schema/mutation_option.dart';
import 'package:noodle/src/core/schema/mutations/login.mutation.dart';
import 'package:noodle/src/core/schema/mutations/register.mutation.dart';
import 'package:noodle/src/core/schema/queries/get_user.query.dart';

// @chungquantin
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  /// {@macro authentication_repository}
  AuthenticationRepository();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.FETCHING_CURRENT_USER;
    yield* _controller.stream;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<RamenApiResponse?> register({
    required username,
    required password,
    required email,
    required phone,
    required firstName,
    required lastName,
  }) async {
    GraphQLClient client = await getClient();

    final QueryResult res = await client
        .mutate(getMutationOptions(schema: getRegisterMutation, variables: {
      "data": {
        "username": username,
        "password": password,
        "email": email,
        "phoneNumber": phone,
        "firstName": firstName,
        "lastName": lastName,
      },
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return RamenApiResponse(
        path: 'flutter_error',
        message: res.exception.toString(),
      );
    }

    if (res.isLoading) {
      print("Loading...");
    }

    dynamic responseData = res.data['register'];

    if (responseData == null) return null;

    return RamenApiResponse(
      message: responseData['message'],
      path: responseData['path'],
    );
  }

  Future<RamenApiResponse?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    GraphQLClient client = await getClient();

    final QueryResult res = await client
        .mutate(getMutationOptions(schema: getLoginMutation, variables: {
      "data": {
        "email": email,
        "password": password,
      },
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return RamenApiResponse(
        path: 'flutter_error',
        message: res.exception.toString(),
      );
    }

    if (res.isLoading) {
      print("Loading...");
    }

    dynamic responseData = res.data['login'];

    if (responseData == null) return null;

    return RamenApiResponse(
      message: responseData['message'],
      path: responseData['path'],
    );
  }

  Future<http.Response> logout() async {
    try {
      http.Response res = await http.post(
        Uri.https(ApiEndpoint.authority, ApiEndpoint.logout),
      );

      if (res.statusCode == 200) {
        log("Logged In Successfully -> Authenticated");
        _controller.add(AuthenticationStatus.UNAUTHENTICATED);
      }

      return res;
    } on Exception {
      throw LogOutFailure();
    }
  }

//This is for testing only
  void setAuthenticated() {
    _controller.add(AuthenticationStatus.AUTHENTICATED);
  }

//This is for testing only
  void setUnauthenticated() {
    _controller.add(AuthenticationStatus.UNAUTHENTICATED);
  }

  void dispose() => _controller.close();
}
