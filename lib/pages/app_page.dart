import 'package:bukafranchise/bloc/auth/auth_bloc.dart';
import 'package:bukafranchise/pages/buyer/widget/bottom_navbar.dart';
import 'package:bukafranchise/pages/login.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print('STATE SPLASH LISTENER = $state');
        if (state.status == AuthenticationStatus.unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName,
              (route) {
            return route.settings.name == ModalRoute.of(context)!.settings.name
                ? true
                : false;
          });
        } else if (state.status == AuthenticationStatus.authenticated) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavbarPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        print('STATE SPLASH BUILDER = $state');
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
