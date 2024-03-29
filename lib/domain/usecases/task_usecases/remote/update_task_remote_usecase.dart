import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class UpdateTaskUseCase extends FutureUseCase<UpdateTaskParams, void> {
  final TaskRepository _taskRepository;

  UpdateTaskUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> execute(UpdateTaskParams params) async {
    _taskRepository.updateTask(
      uid: params.uid,
      taskModel: params.taskModel,
    );
  }
}
