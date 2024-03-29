import 'package:hive_flutter/hive_flutter.dart';

import '/data/entity/task/task_entity.dart';
import '/data/entity/user/user_entity.dart';

class HiveProvider {
  Future<void> saveUser({required UserEntity userEntity}) async {
    final Box<UserEntity> userBox = await Hive.openBox('user');
    await userBox.clear();
    await userBox.add(userEntity);
  }

  Future<UserEntity> getUser() async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    return userBox.isNotEmpty ? userBox.values.first : const UserEntity.empty();
  }

  Future<void> deleteUser() async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    await userBox.clear();
  }

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

  Future<List<TaskEntity>> getTasks({required String uid}) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');

    return tasksBox.values.toList();
  }

  Future<void> addTask({
    required String uid,
    required TaskEntity taskEntity,
  }) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');

    await tasksBox.put(taskEntity.id, taskEntity);
  }

  Future<void> deleteTask({
    required String uid,
    required String taskId,
  }) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');

    await tasksBox.delete(taskId);
  }

  Future<void> updateTask({
    required String uid,
    required TaskEntity taskEntity,
  }) async {
    final Box<TaskEntity> tasksBox = await Hive.openBox('tasks$uid');
    await tasksBox.put(taskEntity.id, taskEntity);
  }
}
