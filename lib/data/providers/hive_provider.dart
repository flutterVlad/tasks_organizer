import 'package:hive_flutter/hive_flutter.dart';

import '/data/entity/task/task_entity.dart';
import '/data/entity/user/user_entity.dart';

/// Provicer for [Hive].
class HiveProvider {
  /// Saves the [UserEntity] to [Hive].
  Future<void> saveUser({required UserEntity userEntity}) async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    await userBox.clear();
    await userBox.add(userEntity);
  }

  /// Returns the [UserEntity] from [Hive].
  Future<UserEntity> getUser() async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    return userBox.isNotEmpty ? userBox.values.first : const UserEntity.empty();
  }

  /// Deletes the [UserEntity] from [Hive].
  Future<void> deleteUser() async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    await userBox.clear();
  }

  /// Saves the [TaskEntity] to [Hive].
  Future<void> saveTasks({
    required String uid,
    required List<TaskEntity> tasks,
  }) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');

    if (tasksBox.isNotEmpty) {
      await tasksBox.clear();
    }

    await tasksBox.addAll(tasks);
  }

  /// Returns the list of [TaskEntity] from [Hive].
  Future<List<TaskEntity>> getTasks({required String uid}) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');

    return tasksBox.values.toList();
  }

  /// Adds the [TaskEntity] to [Hive].
  Future<void> addTask({
    required String uid,
    required TaskEntity taskEntity,
  }) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');

    await tasksBox.put(taskEntity.id, taskEntity);
  }

  /// Deletes the [TaskEntity] from [Hive].
  Future<void> deleteTask({
    required String uid,
    required String taskId,
  }) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');

    await tasksBox.delete(taskId);
  }

  /// Updates the [TaskEntity] in [Hive].
  Future<void> updateTask({
    required String uid,
    required TaskEntity taskEntity,
  }) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');
    await tasksBox.put(taskEntity.id, taskEntity);
  }
}
