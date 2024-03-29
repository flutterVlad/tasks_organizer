part of 'auth_bloc.dart';

abstract class AuthEvent {}

class InitEvent implements AuthEvent {
  const InitEvent();
}

class SignInEvent implements AuthEvent {
  final SignInParams params;
  final VoidCallback onDone;

  const SignInEvent({required this.params, required this.onDone});
}

class SignUpEvent implements AuthEvent {
  final SignUpParams params;
  final VoidCallback onDone;

  const SignUpEvent({required this.params, required this.onDone});
}

class NavigateSignUpEvent implements AuthEvent {}

class NavigateSignInEvent implements AuthEvent {}
