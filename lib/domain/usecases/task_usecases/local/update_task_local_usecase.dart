import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class UpdateTaskLocalUseCase extends FutureUseCase<UpdateTaskParams, void> {
  final TaskRepository _taskRepository;

  UpdateTaskLocalUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> execute(UpdateTaskParams params) async {
    _taskRepository.updateTaskLocal(
      uid: params.uid,
      taskModel: params.taskModel,
    );
  }
}
