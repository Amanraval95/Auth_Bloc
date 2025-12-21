import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/auth_bloc/auth_bloc.dart';
import 'auth/auth_bloc/auth_state.dart';
import 'auth/auth_pages/LoginPage.dart';
import 'home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return HomePage();
          } else if (state is AuthFailure) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
