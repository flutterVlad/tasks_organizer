import '/domain/models/task/task_model.dart';

abstract class FutureUseCase<Input, Output> {
  Future<Output> execute(Input input);
}

class NoParams {
  const NoParams();
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}

class SignUpParams {
  final String userName;
  final String email;
  final String password;

  SignUpParams({
    required this.userName,
    required this.email,
    required this.password,
  });
}

class AddTaskParams {
  final String uid;
  final TaskModel taskModel;

  AddTaskParams({
    required this.uid,
    required this.taskModel,
  });
}

class DeleteTaskParams {
  final String uid;
  final String taskId;

  DeleteTaskParams({
    required this.uid,
    required this.taskId,
  });
}

class UpdateTaskParams {
  final String uid;
  final TaskModel taskModel;

  UpdateTaskParams({
    required this.uid,
    required this.taskModel,
  });
}
