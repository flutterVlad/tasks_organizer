import '/data/entity/task/task_entity.dart';
import '/domain/models/task/task_model.dart';

/// Converter for [TaskEntity] and [TaskModel] objects.
class TaskMapper {
  /// Convert [TaskEntity] to [TaskModel].
  static TaskModel toModel(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      taskName: entity.taskName,
      description: entity.description,
      startTime: entity.startTime,
      lastUpdate: entity.lastUpdate,
      endTime: entity.endTime,
      isCompleted: entity.isCompleted,
    );
  }

  /// Convert [TaskModel] to [TaskEntity].
  static TaskEntity toEntity(TaskModel model) {
    return TaskEntity(
      id: model.id,
      taskName: model.taskName,
      description: model.description,
      startTime: model.startTime,
      lastUpdate: model.lastUpdate,
      endTime: model.endTime,
      isCompleted: model.isCompleted,
    );
  }
}
