import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kortoba_task/UI/screens/fav_screen.dart';
import 'package:kortoba_task/UI/screens/home_screen.dart';
import 'package:kortoba_task/UI/screens/login_screen.dart';
import 'package:kortoba_task/UI/screens/singup_screen.dart';
import 'package:kortoba_task/bussiness_logic/register/register_cubit.dart';
import 'package:kortoba_task/constant/strings.dart';
import 'package:kortoba_task/controls/control_flow.dart';

class AppRouter {
  Route? generateRouts(RouteSettings settings) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute(builder: (_) =>
        const ControlFlow());
      case login:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => RegisterCubit(),
              child: LoginScreen(),
            ));
      case signup:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => RegisterCubit(),
              child: SignupScreen(),
            ));
      case home:
        final acc = settings.arguments;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => RegisterCubit(),
              child: HomeScreen(acc: acc),
            ));
      case fav:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => RegisterCubit(),
              child: const FavScreen(),
            ));
    }
  }
}