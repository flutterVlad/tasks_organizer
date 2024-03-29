import '/domain/models/task/task_model.dart';
import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class GetAllTasksLocalUseCase extends FutureUseCase<String, List<TaskModel>> {
  final TaskRepository _taskRepository;

  GetAllTasksLocalUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<List<TaskModel>> execute(String input) async {
    return _taskRepository.getAllTasksLocal(uid: input);
  }
}
