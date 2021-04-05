import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noodle/src/constants/api_endpoint.dart';

// @chungquantin
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  /// {@macro authentication_repository}
  AuthenticationRepository();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<http.Response> register(
      {username,
      password,
      confirmPassword,
      email,
      phone,
      firstName,
      lastName}) async {
    try {
      http.Response res = await http.post(
        Uri.https(ApiEndpoint.authority, ApiEndpoint.register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "data": {
            'username': username,
            'password': password,
            'email': email,
            'phoneNumber': phone,
            'firstName': firstName,
            'lastName': lastName,
          },
        }),
      );

      return res;
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<http.Response> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    assert(email != null && password != null);
    try {
      http.Response res = await http.post(
        Uri.https(ApiEndpoint.authority, ApiEndpoint.login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'data': {
            'email': email,
            'password': password,
          },
        }),
      );

      if (res.statusCode == 200) {
        log("Logged In Successfully -> Authenticated");
        _controller.add(AuthenticationStatus.authenticated);
      }

      return res;
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<http.Response> logout() async {
    try {
      http.Response res = await http.post(
        Uri.https(ApiEndpoint.authority, ApiEndpoint.logout),
      );

      if (res.statusCode == 200) {
        log("Logged In Successfully -> Authenticated");
        _controller.add(AuthenticationStatus.unauthenticated);
      }

      return res;
    } on Exception {
      throw LogOutFailure();
    }
  }

  void dispose() => _controller.close();
}
