import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class AddTaskUseCase extends FutureUseCase<AddTaskParams, void> {
  final TaskRepository _taskRepository;

  AddTaskUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> execute(AddTaskParams params) async {
    _taskRepository.addTask(
      uid: params.uid,
      taskModel: params.taskModel,
    );
  }
}
