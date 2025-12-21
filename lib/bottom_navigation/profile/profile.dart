import 'package:auth_bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:auth_bloc/auth/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
