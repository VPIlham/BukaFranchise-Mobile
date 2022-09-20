import 'package:bukafranchise/bloc/auth/auth_bloc.dart';
import 'package:bukafranchise/bloc/cubit/login_cubit.dart';
import 'package:bukafranchise/pages/buyer/home/home.dart';
import 'package:bukafranchise/pages/login.dart';
import 'package:bukafranchise/pages/register.dart';
import 'package:bukafranchise/pages/app_page.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:bukafranchise/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'BukaFranchise',
    //   debugShowCheckedModeBanner: false,
    //   // supportedLocales: [Locale('en'), Locale('id', 'ID')],
    //   initialRoute: '/',
    //   home: BottomNavbarSellerPage(),
    // );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'BukaFranchise',
          debugShowCheckedModeBanner: false,
          home: const AppPage(),
          routes: {
            RegisterPage.routeName: (context) => const RegisterPage(),
            LoginPage.routeName: (context) => const LoginPage(),
            HomePage.routeName: (context) => const HomePage(),
          },
        ),
      ),
    );
  }
}
