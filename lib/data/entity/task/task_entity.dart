class TaskEntity {
  final String id;
  final String taskName;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime lastUpdate;
  final bool isCompleted;

  const TaskEntity({
    required this.id,
    required this.taskName,
    required this.description,
    required this.startTime,
    required this.lastUpdate,
    required this.endTime,
    required this.isCompleted,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'] ?? '',
      taskName: json['taskName'] ?? '',
      description: json['description'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      lastUpdate: DateTime.parse(json['lastUpdate']),
      endTime: DateTime.parse(json['endTime']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  TaskEntity copyWith({
    String? id,
    String? taskName,
    String? description,
    DateTime? startTime,
    DateTime? lastUpdate,
    DateTime? endTime,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'description': description,
      'startTime': startTime.toString(),
      'lastUpdate': lastUpdate.toString(),
      'endTime': endTime.toString(),
      'isCompleted': isCompleted,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is TaskEntity &&
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
