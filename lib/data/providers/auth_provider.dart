import 'package:firebase_auth/firebase_auth.dart';

import '../entity/user/user_entity.dart';
import 'firestore_provider.dart';
import 'hive_provider.dart';

/// Provider for authentication.
class AuthProvider {
  /// Instance of the [FirebaseAuth].
  final FirebaseAuth _firebaseAuth;

  /// Instance of the [FirestoreProvider].
  final FirestoreProvider _firestoreProvider;

  /// Instance of the [HiveProvider].
  final HiveProvider _hiveProvider;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required FirestoreProvider firestoreProvider,
    required HiveProvider hiveProvider,
  })  : _firebaseAuth = firebaseAuth,
        _firestoreProvider = firestoreProvider,
        _hiveProvider = hiveProvider;

  /// Signs up the user with [email] and [password].
  Future<UserEntity> signUpWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  }) async {
    final UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final UserEntity userEntity = UserEntity(
      uid: credential.user?.uid ?? '',
      email: email,
      userName: userName,
    );

    await _firestoreProvider.saveUser(userEntity: userEntity);

    return userEntity;
  }

  /// Signs in the user with [email] and [password].
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential credential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final UserEntity userEntity = await _firestoreProvider.getUser(
      uid: credential.user?.uid ?? '',
    );

    return userEntity;
  }

  /// Signs out the user.
  Future<void> signOut() async {
    await _hiveProvider.deleteUser();
    await _firebaseAuth.signOut();
  }
}
