import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        add(AppLogoutEvent());
      } else {
        add(AppLoginEvent(user));
      }
    });

    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_signUp);
    on<LogoutEvent>(_onLogout);

    on<AppLoginEvent>((event, emit) {
      emit(AuthSuccess(event.user));
    });

    on<AppLogoutEvent>((event, emit) {
      emit(AuthInitial());
    });
  }
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(credential.user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _signUp(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(credential.user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _auth.signOut();
    emit(AuthInitial());
  }
}
