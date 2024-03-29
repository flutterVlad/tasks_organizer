import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/models/user/user_model.dart';
import '/domain/usecases/export_usecases.dart';
import '/navigation/app_router/app_router.dart';
import 'auth_from_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final GetUserFromStorageUseCase _getUserFromStorageUseCase;
  final AppRouter _router;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required GetUserFromStorageUseCase getUserFromStorageUseCase,
    required AppRouter router,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _getUserFromStorageUseCase = getUserFromStorageUseCase,
        _router = router,
        super(const AuthState.empty()) {
    on<InitEvent>(_init);
    on<SignInEvent>(_signIn);
    on<SignUpEvent>(_signUp);
    on<NavigateSignInEvent>(_navigateToSignIn);
    on<NavigateSignUpEvent>(_navigateToSignUp);

    add(const InitEvent());
  }

  Future<void> _init(InitEvent event, Emitter<AuthState> emit) async {
    final UserModel user = await _getUserFromStorageUseCase.execute(
      const NoParams(),
    );

    if (user != const UserModel.empty()) {
      emit(
        state.copyWith(
          user: user,
          authFormState: const SeccessFromState(),
        ),
      );
      _router.navigate(const HomeRoute());
    }
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      final UserModel user = await _signInUseCase.execute(event.params);

      if (user != const UserModel.empty()) {
        emit(
          state.copyWith(
            user: user,
            authFormState: const SeccessFromState(),
          ),
        );
        _router.navigate(const HomeRoute());
        event.onDone.call();
      }
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          authFormState: ErrorFromState(message: error.message ?? ''),
        ),
      );
    }
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      final UserModel user = await _signUpUseCase.execute(event.params);

      if (user != const UserModel.empty()) {
        emit(
          state.copyWith(
            user: user,
            authFormState: const SeccessFromState(),
          ),
        );
        _router.navigate(const HomeRoute());
        event.onDone.call();
      }
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          authFormState: ErrorFromState(message: error.message ?? ''),
        ),
      );
    }
  }

  Future<void> _navigateToSignUp(_, Emitter<AuthState> emit) async {
    emit(state.copyWith(authType: AuthType.signUp));
  }

  Future<void> _navigateToSignIn(_, Emitter<AuthState> emit) async {
    emit(state.copyWith(authType: AuthType.signIn));
  }
}
