import 'package:hive_flutter/hive_flutter.dart';

import '/core/hive_adapters_id/adapters_id.dart';
import '/data/entity/task/task_entity.dart';

/// Hive adapter for [TaskEntity].
class TaskAdapter extends TypeAdapter<TaskEntity> {
  @override
  final int typeId = AdaptersId.task;

  @override
  TaskEntity read(BinaryReader reader) {
    final String id = reader.readString();
    final String taskName = reader.readString();
    final String description = reader.readString();
    final DateTime startTime = DateTime.parse(reader.readString());
    final DateTime lastUpdate = DateTime.parse(reader.readString());
    final DateTime endTime = DateTime.parse(reader.readString());
    final bool isCompleted = reader.readBool();

    return TaskEntity(
      id: id,
      taskName: taskName,
      description: description,
      startTime: startTime,
      lastUpdate: lastUpdate,
      endTime: endTime,
      isCompleted: isCompleted,
    );
  }

  @override
  void write(BinaryWriter writer, TaskEntity obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.taskName);
    writer.writeString(obj.description);
    writer.writeString(obj.startTime.toString());
    writer.writeString(obj.lastUpdate.toString());
    writer.writeString(obj.endTime.toString());
    writer.writeBool(obj.isCompleted);
  }
}
