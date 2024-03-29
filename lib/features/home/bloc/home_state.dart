part of 'home_bloc.dart';

class HomeState {
  final UserModel user;
  final List<TaskModel> tasks;
  final bool internetConnection;
  final bool isLoading;

  const HomeState({
    required this.user,
    required this.tasks,
    required this.internetConnection,
    required this.isLoading,
  });

  const HomeState.empty()
      : user = const UserModel.empty(),
        tasks = const [],
        internetConnection = true,
        isLoading = false;

  HomeState copyWith({
    UserModel? user,
    List<TaskModel>? tasks,
    bool? internetConnection,
    bool? isLoading,
  }) {
    return HomeState(
      user: user ?? this.user,
      tasks: tasks ?? this.tasks,
      internetConnection: internetConnection ?? this.internetConnection,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
