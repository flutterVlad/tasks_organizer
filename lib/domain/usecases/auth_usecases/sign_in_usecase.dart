import '../usecases.dart';
import '../../repositories/auth_repository.dart';
import '../../models/user/user_model.dart';

class SignInUseCase implements FutureUseCase<SignInParams, UserModel> {
  final AuthRepository _authRepository;

  SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<UserModel> execute(SignInParams params) async {
    return _authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}
