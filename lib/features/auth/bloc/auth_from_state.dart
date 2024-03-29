abstract class AuthFormState {}

class InitFormState implements AuthFormState {
  const InitFormState();
}

class SeccessFromState implements AuthFormState {
  const SeccessFromState();
}

class ErrorFromState implements AuthFormState {
  final String message;

  const ErrorFromState({required this.message});

  @override
  String toString() => message;
}
