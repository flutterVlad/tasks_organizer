import '../usecases.dart';
import '/domain/repositories/auth_repository.dart';
import '/domain/models/user/user_model.dart';

class GetUserFromStorageUseCase implements FutureUseCase<NoParams, UserModel> {
  final AuthRepository _authRepository;

  GetUserFromStorageUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<UserModel> execute(NoParams input) async {
    return _authRepository.getUserFromStorage();
  }
}
