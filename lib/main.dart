import 'package:ewallet_app/blocs/auth/auth_bloc.dart';
import 'package:ewallet_app/blocs/user/user_bloc.dart';
import 'package:ewallet_app/shared/theme.dart';
import 'package:ewallet_app/ui/pages/data_provider_page.dart';
import 'package:ewallet_app/ui/pages/data_success_page.dart';
import 'package:ewallet_app/ui/pages/home_page.dart';
import 'package:ewallet_app/ui/pages/pin_page.dart';
import 'package:ewallet_app/ui/pages/profile_page.dart';
import 'package:ewallet_app/ui/pages/sign_in_page.dart';
import 'package:ewallet_app/ui/pages/sign_up_page.dart';
import 'package:ewallet_app/ui/pages/sign_up_success_page.dart';
import 'package:ewallet_app/ui/pages/splash_page.dart';
import 'package:ewallet_app/ui/pages/topup_page.dart';
import 'package:ewallet_app/ui/pages/topup_success_page.dart';
import 'package:ewallet_app/ui/pages/transfer_page.dart';
import 'package:ewallet_app/ui/pages/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurretUser()),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: lightBackgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: lightBackgroundColor,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: blackColor),
              titleTextStyle:
                  blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
            )),
        routes: {
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/sign-up-success': (context) => const SignUpSuccessPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/pin': (context) => const PinPage(),
          '/topup': (context) => const TopupPage(),
          '/topup-success': (context) => const TopupSuccessPage(),
          '/transfer': (context) => const TransferPage(),
          '/transfer-success': (context) => const TransferSuccessPage(),
          '/data-provider': (context) => const DataProviderPage(),
          '/data-success': (context) => const DataSuccessPage(),
        },
      ),
    );
  }
}
