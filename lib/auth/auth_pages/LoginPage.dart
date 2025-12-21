import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_page/home_page.dart';
import '../auth_bloc/auth_bloc.dart';
import '../auth_bloc/auth_event.dart';
import '../auth_bloc/auth_state.dart';
import 'SignUp_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],

      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Align(
          alignment: .center,
          child: Card(
            color: Colors.green[100],
            margin: .only(left: 14, right: 14),
            child: Padding(
              padding: .all(20),
              child: Column(
                mainAxisSize: .min,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => context.read<AuthBloc>().add(
                              LoginEvent(
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                              ),
                            ),
                            child: const Text("login"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignupPage()),
                            ),
                            child: Text(
                              "Dont have an Account ?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
