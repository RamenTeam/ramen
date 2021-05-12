import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/repositories/notification_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/auth/auth_landing.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_bloc.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/login_navigation/bloc/login_navigation_bloc.dart';
import 'package:noodle/src/resources/pages/notifications/bloc/notification_cubit.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/theme/theme.dart';
import 'package:noodle/src/temp/signaling_temp/signal_screen.dart';
import 'package:provider/provider.dart';

class RamenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // TODO Change this to route to development screen
    bool isDevelopedRoute = false;
    Widget developedRoute = HomeScreen();
    return MaterialApp(
      title: "Ramen",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.of(context, listen: true).currentTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (_) => UserCubit(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            ), // Auto login for testing, please comment this on production
          ),
          BlocProvider<LoginNavigationBloc>(
            create: (_) => LoginNavigationBloc(),
          ),
          BlocProvider<SignalingBloc>(create: (_) => SignalingBloc()),
          BlocProvider<NotificationCubit>(
            create: (_) => NotificationCubit(
                notificationRepository: Provider.of<NotificationRepository>(
                    context,
                    listen: false)),
          ),
        ],
        child: isDevelopedRoute ? developedRoute : AuthLanding(),
      ),
    );
  }
}
