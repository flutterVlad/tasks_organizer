import '/domain/models/task/task_model.dart';
import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class GetAllTasksUseCase extends FutureUseCase<String, List<TaskModel>> {
  final TaskRepository _taskRepository;

  GetAllTasksUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<List<TaskModel>> execute(String input) async {
    return _taskRepository.getAllTasks(uid: input);
  }
}
