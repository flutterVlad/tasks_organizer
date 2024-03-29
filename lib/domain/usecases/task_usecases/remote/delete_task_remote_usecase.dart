import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class DeleteTaskUseCase extends FutureUseCase<DeleteTaskParams, void> {
  final TaskRepository _taskRepository;

  DeleteTaskUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> execute(DeleteTaskParams params) async {
    _taskRepository.deleteTask(
      uid: params.uid,
      taskId: params.taskId,
    );
  }
}
