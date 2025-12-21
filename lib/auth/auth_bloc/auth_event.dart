import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  const SignupEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class LogoutEvent extends AuthEvent {}

class AppLoginEvent extends AuthEvent {
  final User user;
  const AppLoginEvent(this.user);
  @override
  List<Object?> get props => [user.uid];
}

class AppLogoutEvent extends AuthEvent {}
