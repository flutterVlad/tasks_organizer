import '/data/entity/task/task_entity.dart';
import '/domain/models/task/task_model.dart';

class TaskMapper {
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
