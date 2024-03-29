part of 'auth_bloc.dart';

class AuthState {
  final UserModel user;
  final AuthType authType;
  final AuthFormState? authFormState;

  const AuthState({
    required this.user,
    required this.authType,
    this.authFormState,
  });

  const AuthState.empty()
      : user = const UserModel.empty(),
        authType = AuthType.signIn,
        authFormState = const InitFormState();

  AuthState copyWith({
    UserModel? user,
    AuthType? authType,
    AuthFormState? authFormState,
  }) {
    return AuthState(
      user: user ?? this.user,
      authType: authType ?? this.authType,
      authFormState: authFormState,
    );
  }
}

enum AuthType { signIn, signUp }
