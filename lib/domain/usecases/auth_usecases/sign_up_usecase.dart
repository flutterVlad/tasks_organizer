import '../usecases.dart';
import '../../repositories/auth_repository.dart';
import '../../models/user/user_model.dart';

class SignUpUseCase implements FutureUseCase<SignUpParams, UserModel> {
  final AuthRepository _authRepository;

  SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<UserModel> execute(SignUpParams params) async {
    return _authRepository.signUp(
      userName: params.userName,
      email: params.email,
      password: params.password,
    );
  }
}
