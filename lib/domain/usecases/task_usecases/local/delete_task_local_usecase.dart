import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class DeleteTaskLocalUseCase extends FutureUseCase<DeleteTaskParams, void> {
  final TaskRepository _taskRepository;

  DeleteTaskLocalUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> execute(DeleteTaskParams params) async {
    _taskRepository.deleteTaskLocal(
      uid: params.uid,
      taskId: params.taskId,
    );
  }
}
