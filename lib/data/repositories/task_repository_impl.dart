import '/data/entity/task/task_entity.dart';
import '/data/mappers/task_mapper.dart';
import '/data/providers/firestore_provider.dart';
import '/data/providers/hive_provider.dart';
import '/domain/models/task/task_model.dart';
import '/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final FirestoreProvider _firestoreProvider;
  final HiveProvider _hiveProvider;

  TaskRepositoryImpl({
    required FirestoreProvider firestoreProvider,
    required HiveProvider hiveProvider,
  })  : _firestoreProvider = firestoreProvider,
        _hiveProvider = hiveProvider;

  @override
  Future<List<TaskModel>> getAllTasks({
    required String uid,
  }) async {
    final List<TaskEntity> listOfTaskEntity =
        await _firestoreProvider.getAllTasks(uid: uid);

    await _hiveProvider.saveTasks(
      uid: uid,
      tasks: listOfTaskEntity,
    );

    return listOfTaskEntity
        .map(
          (TaskEntity entity) => TaskMapper.toModel(entity),
        )
        .toList();
  }

  @override
  Future<void> addTask({
    required String uid,
    required TaskModel taskModel,
  }) async {
    await _hiveProvider.addTask(
      uid: uid,
      taskEntity: TaskMapper.toEntity(taskModel),
    );

    await _firestoreProvider.addTask(
      uid: uid,
      taskEntity: TaskMapper.toEntity(taskModel),
    );
  }

  @override
  Future<void> updateTask({
    required String uid,
    required TaskModel taskModel,
  }) async {
    await _hiveProvider.updateTask(
      uid: uid,
      taskEntity: TaskMapper.toEntity(taskModel),
    );

    await _firestoreProvider.updateTask(
      uid: uid,
      taskEntity: TaskMapper.toEntity(taskModel),
    );
  }

  @override
  Future<void> deleteTask({
    required String uid,
    required String taskId,
  }) async {
    await _hiveProvider.deleteTask(uid: uid, taskId: taskId);

    await _firestoreProvider.deleteTask(uid: uid, taskId: taskId);
  }

  @override
  Future<List<TaskModel>> getAllTasksLocal({
    required String uid,
  }) async {
    final List<TaskEntity> listOfTaskEntity = await _hiveProvider.getTasks(
      uid: uid,
    );

    return listOfTaskEntity
        .map(
          (TaskEntity entity) => TaskMapper.toModel(entity),
        )
        .toList();
  }

  @override
  Future<void> addTaskLocal({
    required String uid,
    required TaskModel taskModel,
  }) async {
    await _hiveProvider.addTask(
      uid: uid,
      taskEntity: TaskMapper.toEntity(taskModel),
    );
  }

  @override
  Future<void> updateTaskLocal({
    required String uid,
    required TaskModel taskModel,
  }) async {
    await _firestoreProvider.updateTask(
      uid: uid,
      taskEntity: TaskMapper.toEntity(taskModel),
    );
  }

  @override
  Future<void> deleteTaskLocal({
    required String uid,
    required String taskId,
  }) async {
    await _firestoreProvider.deleteTask(uid: uid, taskId: taskId);
  }

  @override
  Future<void> sincWithFirestore({required String uid}) async {
    final List<TaskEntity> localTasks = await _hiveProvider.getTasks(uid: uid);

    final List<TaskEntity> firestoreTasks =
        await _firestoreProvider.getAllTasks(uid: uid);

    final List<TaskEntity> syncList = _unionTasks(firestoreTasks, localTasks);

    await _hiveProvider.saveTasks(
      uid: uid,
      tasks: syncList,
    );

    await _firestoreProvider.updateTasks(
      uid: uid,
      tasks: syncList,
    );
  }

  List<TaskEntity> _unionTasks(
    List<TaskEntity> remoteTasks,
    List<TaskEntity> localTasks,
  ) {
    final List<TaskEntity> syncList = [];
    final Map<String, TaskEntity> localMap = {
      for (TaskEntity item in localTasks) item.id: item
    };

    final Map<String, TaskEntity> firestoreMap = {
      for (TaskEntity item in remoteTasks) item.id: item
    };

    final List<TaskEntity> biggestList =
        localTasks.length > remoteTasks.length ? localTasks : remoteTasks;

    for (TaskEntity task in biggestList) {
      if (biggestList == remoteTasks) {
        if (localMap.containsKey(task.id)) {
          final TaskEntity localTask = localMap[task.id]!;

          if (localTask != task &&
              task.lastUpdate.compareTo(localTask.lastUpdate) < 0) {
            syncList.add(localTask);
          } else {
            syncList.add(task);
          }
        } else {
          syncList.add(task);
        }
      } else {
        if (firestoreMap.containsKey(task.id)) {
          final TaskEntity remoteTask = firestoreMap[task.id]!;

          if (remoteTask != task &&
              task.lastUpdate.compareTo(remoteTask.lastUpdate) < 0) {
            syncList.add(remoteTask);
          } else {
            syncList.add(task);
          }
        } else {
          syncList.add(task);
        }
      }
    }

    return syncList;
  }
}
