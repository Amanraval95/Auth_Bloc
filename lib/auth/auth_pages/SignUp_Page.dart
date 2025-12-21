import 'package:auth_bloc/auth/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_page/home_page.dart';
import '../auth_bloc/auth_bloc.dart';
import '../auth_bloc/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {}
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Align(
          alignment: .center,
          child: Card(
            margin: .only(left: 14, right: 14),
            child: Padding(
              padding: const .all(20),
              child: Column(
                mainAxisSize: .min,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: "passwword",
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        SignupEvent(
                          email: emailController.text.trim(),
                          password: passController.text.trim(),
                        ),
                      );
                    },
                    child: Text("SignUp"),
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
