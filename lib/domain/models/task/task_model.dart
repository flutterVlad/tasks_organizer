class TaskModel {
  final String id;
  final String taskName;
  final String description;
  final DateTime startTime;
  final DateTime lastUpdate;
  final DateTime endTime;
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
