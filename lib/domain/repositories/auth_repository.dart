import '/domain/models/user/user_model.dart';

/// Abstraction for the Authentication.
abstract class AuthRepository {
  /// Signs up a new user and returns [UserModel].
  Future<UserModel> signUp({
    required String userName,
    required String email,
    required String password,
  });

  /// Signs in an existing user and returns [UserModel].
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  /// Signs out the current user.
  Future<void> signOut();

  /// Gets the current user from storage.
  Future<UserModel> getUserFromStorage();
}
