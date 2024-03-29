part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitEvent implements HomeEvent {
  const InitEvent();
}

class GetAllTasksEvent implements HomeEvent {
  const GetAllTasksEvent();
}

class CheckInternetEvent implements HomeEvent {
  final List<ConnectivityResult> results;

  const CheckInternetEvent({required this.results});
}

class SignOutEvent implements HomeEvent {
  const SignOutEvent();
}

class AddTaskEvent implements HomeEvent {
  final TaskModel task;

  const AddTaskEvent({required this.task});
}

class DeleteTaskEvent implements HomeEvent {
  final String taskId;

  const DeleteTaskEvent({required this.taskId});
}

class UpdateTaskEvent implements HomeEvent {
  final TaskModel task;

  const UpdateTaskEvent({required this.task});
}

class SyncTasksEvent implements HomeEvent {
  const SyncTasksEvent();
}

class NavigateToAddEvent implements HomeEvent {
  const NavigateToAddEvent();
}
