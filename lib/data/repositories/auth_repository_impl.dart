import '/domain/models/user/user_model.dart';
import '/domain/repositories/auth_repository.dart';
import '../entity/user/user_entity.dart';
import '../mappers/user_mapper.dart';
import '../providers/auth_provider.dart';
import '../providers/hive_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _authProvider;
  final HiveProvider _hiveProvider;

  AuthRepositoryImpl({
    required AuthProvider authProvider,
    required HiveProvider hiveProvider,
  })  : _authProvider = authProvider,
        _hiveProvider = hiveProvider;

  @override
  Future<UserModel> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    final UserEntity userEntity =
        await _authProvider.signUpWithEmailAndPassword(
      userName: userName,
      email: email,
      password: password,
    );

    await _hiveProvider.saveUser(userEntity: userEntity);
    return UserMapper.toModel(userEntity);
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final UserEntity userEntity =
        await _authProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _hiveProvider.saveUser(userEntity: userEntity);
    return UserMapper.toModel(userEntity);
  }

  @override
  Future<void> signOut() async {
    await _authProvider.signOut();
  }

  @override
  Future<UserModel> getUserFromStorage() async {
    final UserEntity userEntity = await _hiveProvider.getUser();

    return UserMapper.toModel(userEntity);
  }
}
