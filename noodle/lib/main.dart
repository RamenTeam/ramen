import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noodle/app.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/repositories/connection_repository.dart';
import 'package:noodle/src/core/repositories/notification_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/theme/theme.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppTheme(),
        ),
        Provider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        Provider<NotificationRepository>(
          create: (_) => NotificationRepository(),
        ),
        Provider<ConnectionRepository>(
          create: (_) => ConnectionRepository(),
        ),
        Provider<GraphQLProvider>(
          create: (_) => GraphQLProvider(
            client: ValueNotifier(getGraphQLWebsocketClient()),
          ),
        )
      ],
      child: RamenApp(),
    ),
  );
}
