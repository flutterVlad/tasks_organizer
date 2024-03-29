import '/domain/repositories/task_repository.dart';
import '/domain/usecases/usecases.dart';

class SyncTasksUseCase extends FutureUseCase<String, void> {
  final TaskRepository _taskRepository;

  SyncTasksUseCase({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<void> execute(String input) async {
    _taskRepository.sincWithFirestore(
      uid: input,
    );
  }
}
