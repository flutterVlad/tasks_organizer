import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/user/user_entity.dart';

class FirestoreProvider {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreProvider({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  Future<void> saveUser({required UserEntity userEntity}) async {
    final DocumentReference<Map<String, dynamic>> userData =
        _firebaseFirestore.collection('users').doc('uid');

    final DocumentSnapshot<Map<String, dynamic>> user = await userData.get();

    if (!user.exists) {
      await userData.set(userEntity.toMap());
    }
  }

  Future<UserEntity> getUser({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection('users').doc(uid).get();

    return UserEntity.fromJson(snapshot.data() ?? {});
  }
}
