import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class AddTaskLocalUseCase extends FutureUseCase<AddTaskParams, void> {
  final TaskRepository _taskRepository;

  AddTaskLocalUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> execute(AddTaskParams params) async {
    _taskRepository.addTaskLocal(
      uid: params.uid,
      taskModel: params.taskModel,
    );
  }
}
