import '/domain/models/task/task_model.dart';

/// Abstraction for the task repository.
abstract class TaskRepository {
  /// Adds a new [TaskModel] to the `FirebaseFirestore`.
  Future<void> addTask({
    required String uid,
    required TaskModel taskModel,
  });

  /// Updates the [TaskModel] in the `FirebaseFirestore`.
  Future<void> updateTask({
    required String uid,
    required TaskModel taskModel,
  });

  /// Deletes the [TaskModel] from the `FirebaseFirestore`.
  Future<void> deleteTask({
    required String uid,
    required String taskId,
  });

  /// Returns the list of [TaskModel]s from the `FirebaseFirestore`.
  Future<List<TaskModel>> getAllTasks({
    required String uid,
  });

  /// Adds a new [TaskModel] to the `Hive`.
  Future<void> addTaskLocal({
    required String uid,
    required TaskModel taskModel,
  });

  /// Updates the [TaskModel] in the `Hive`.
  Future<void> updateTaskLocal({
    required String uid,
    required TaskModel taskModel,
  });

  /// Deletes the [TaskModel] from the `Hive`.
  Future<void> deleteTaskLocal({
    required String uid,
    required String taskId,
  });

  /// Returns the list of [TaskModel]s from the `Hive`.
  Future<List<TaskModel>> getAllTasksLocal({
    required String uid,
  });

  /// Synchronizes the data from `Hive` and `FirebaseFirestore`.
  Future<void> sincWithFirestore({required String uid});
}
