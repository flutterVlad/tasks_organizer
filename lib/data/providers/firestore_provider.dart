import 'package:cloud_firestore/cloud_firestore.dart';

import '/data/entity/task/task_entity.dart';
import '/data/entity/user/user_entity.dart';

class FirestoreProvider {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreProvider({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  Future<void> saveUser({required UserEntity userEntity}) async {
    final DocumentReference<Map<String, dynamic>> userData =
        _firebaseFirestore.collection('users').doc(userEntity.uid);

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

  Future<void> updateTasks({
    required String uid,
    required List<TaskEntity> tasks,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> tasksCollection =
        await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .get();

    for (QueryDocumentSnapshot doc in tasksCollection.docs) {
      await deleteTask(uid: uid, taskId: doc.id);
    }

    for (TaskEntity task in tasks) {
      await addTask(taskEntity: task, uid: uid);
    }
  }

  Future<List<TaskEntity>> getAllTasks({required String uid}) async {
    final QuerySnapshot<Map<String, dynamic>> listOfTasks =
        await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .get();

    return listOfTasks.docs.map((
      QueryDocumentSnapshot<Map<String, dynamic>> document,
    ) {
      return TaskEntity.fromJson(document.data());
    }).toList();
  }

  Future<void> addTask({
    required TaskEntity taskEntity,
    required String uid,
  }) async {
    final DocumentReference<Map<String, dynamic>> taskRef = _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc();

    await taskRef.set(taskEntity.copyWith(id: taskRef.id).toMap());
  }

  Future<void> updateTask({
    required String uid,
    required TaskEntity taskEntity,
  }) async {
    final DocumentReference<Map<String, dynamic>> taskData = _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskEntity.id);

    await taskData.update(taskEntity.toMap());
  }

  Future<void> deleteTask({
    required String uid,
    required String taskId,
  }) async {
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
