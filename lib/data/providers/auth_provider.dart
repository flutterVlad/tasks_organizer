import 'package:firebase_auth/firebase_auth.dart';

import '../entity/user/user_entity.dart';
import 'firestore_provider.dart';
import 'hive_provider.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final FirestoreProvider _firestoreProvider;
  final HiveProvider _hiveProvider;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required FirestoreProvider firestoreProvider,
    required HiveProvider hiveProvider,
  })  : _firebaseAuth = firebaseAuth,
        _firestoreProvider = firestoreProvider,
        _hiveProvider = hiveProvider;

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

  Future<void> signOut() async {
    await _hiveProvider.deleteUser();
    await _firebaseAuth.signOut();
  }
}
