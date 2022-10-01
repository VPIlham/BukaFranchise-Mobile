import 'package:bukafranchise/bloc/auth/auth_bloc.dart';
import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/dashboard/dashboard_cubit.dart';
import 'package:bukafranchise/bloc/login/login_cubit.dart';
import 'package:bukafranchise/bloc/mostsold/mostsold_cubit.dart';
import 'package:bukafranchise/bloc/product/product_cubit.dart';
import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/bloc/register/register_cubit.dart';
import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
import 'package:bukafranchise/bloc/wishlist/wishlist_cubit.dart';
import 'package:bukafranchise/pages/buyer/home/home.dart';
import 'package:bukafranchise/pages/login.dart';
import 'package:bukafranchise/pages/register.dart';
import 'package:bukafranchise/pages/app_page.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:bukafranchise/repositories/brand_repository.dart';
import 'package:bukafranchise/repositories/product_repository.dart';
import 'package:bukafranchise/repositories/transaction_repository.dart';
import 'package:bukafranchise/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
    FlutterNativeSplash.remove();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<BrandRepository>(
          create: (context) => BrandRepository(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider<TransactionRepository>(
          create: (context) => TransactionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<BrandCubit>(
            create: (context) => BrandCubit(
              brandRepository: context.read<BrandRepository>(),
            ),
          ),
          BlocProvider<DashboardCubit>(
            create: (context) => DashboardCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<WishlistCubit>(
            create: (context) => WishlistCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(
              productRepository: context.read<ProductRepository>(),
            ),
          ),
          BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(
              transactionRepository: context.read<TransactionRepository>(),
            ),
          ),
          BlocProvider<MostsoldCubit>(
            create: (context) => MostsoldCubit(
              userRepository: context.read<UserRepository>(),
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
          theme: ThemeData(
            primaryColor: Colors.white,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
