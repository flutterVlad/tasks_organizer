/// Model of the task.
class TaskModel {
  /// Id of the task.
  final String id;

  /// Name of the task.
  final String taskName;

  /// Description of the task.
  final String description;

  /// Start time of the task.
  final DateTime startTime;

  /// End time of the task.
  final DateTime endTime;

  /// Last update time of the task.
  ///
  /// Used to determine, which [TaskModel] is newer.
  final DateTime lastUpdate;

  /// Is the task completed.
  final bool isCompleted;

  const TaskModel({
    required this.id,
    required this.taskName,
    required this.description,
    required this.startTime,
    required this.lastUpdate,
    required this.endTime,
    required this.isCompleted,
  });

  /// Returns new [TaskModel] with updated fields.
  TaskModel copyWith({
    String? id,
    String? taskName,
    String? description,
    DateTime? startTime,
    DateTime? lastUpdate,
    DateTime? endTime,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TaskModel &&
        id == other.id &&
        taskName == other.taskName &&
        description == other.description &&
        startTime == other.startTime &&
        lastUpdate == other.lastUpdate &&
        endTime == other.endTime &&
        isCompleted == other.isCompleted;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      taskName,
      description,
      startTime,
      lastUpdate,
      endTime,
      isCompleted,
    );
  }
}
