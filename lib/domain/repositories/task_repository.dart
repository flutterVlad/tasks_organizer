import '../models/task/task_model.dart';

abstract class TaskRepository {
  Future<void> addTask({
    required String uid,
    required TaskModel taskModel,
  });

  Future<void> updateTask({
    required String uid,
    required TaskModel taskModel,
  });

  Future<void> deleteTask({
    required String uid,
    required String taskId,
  });

  Future<List<TaskModel>> getAllTasks({
    required String uid,
  });

  Future<void> addTaskLocal({
    required String uid,
    required TaskModel taskModel,
  });

  Future<void> updateTaskLocal({
    required String uid,
    required TaskModel taskModel,
  });

  Future<void> deleteTaskLocal({
    required String uid,
    required String taskId,
  });

  Future<List<TaskModel>> getAllTasksLocal({
    required String uid,
  });

  Future<void> sincWithFirestore({required String uid});
}
