import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '/data/data.dart';
import '/domain/models/task/task_model.dart';
import '/domain/models/user/user_model.dart';
import '/navigation/app_router/app_router.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllTasksUseCase _getAllTasksUseCase;
  final GetAllTasksLocalUseCase _getAllTasksLocalUseCase;
  final GetUserFromStorageUseCase _getUserFromStorageUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final AddTaskLocalUseCase _addTaskLocalUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final UpdateTaskLocalUseCase _updateTaskLocalUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final DeleteTaskLocalUseCase _deleteTaskLocalUseCase;
  final SyncTasksUseCase _syncTasksUseCase;
  final AppRouter _router;
  late final StreamSubscription _connectivity;

  HomeBloc({
    required GetAllTasksUseCase getAllTasksUseCase,
    required GetAllTasksLocalUseCase getAllTasksLocalUseCase,
    required GetUserFromStorageUseCase getUserFromStorageUseCase,
    required AddTaskUseCase addTaskUseCase,
    required AddTaskLocalUseCase addTaskLocalUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
    required UpdateTaskLocalUseCase updateTaskLocalUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
    required DeleteTaskLocalUseCase deleteTaskLocalUseCase,
    required SyncTasksUseCase syncTasksUseCase,
    required AppRouter router,
  })  : _getAllTasksLocalUseCase = getAllTasksLocalUseCase,
        _getAllTasksUseCase = getAllTasksUseCase,
        _getUserFromStorageUseCase = getUserFromStorageUseCase,
        _addTaskUseCase = addTaskUseCase,
        _addTaskLocalUseCase = addTaskLocalUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        _updateTaskLocalUseCase = updateTaskLocalUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        _deleteTaskLocalUseCase = deleteTaskLocalUseCase,
        _syncTasksUseCase = syncTasksUseCase,
        _router = router,
        super(const HomeState.empty()) {
    on<InitEvent>(_init);
    on<CheckInternetEvent>(_checkInternet);
    on<GetAllTasksEvent>(_getAllTasks);
    on<SignOutEvent>(_signOut);
    on<SyncTasksEvent>(_synchronizeTasks);
    on<AddTaskEvent>(_addTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<UpdateTaskEvent>(_updateTask);
    on<NavigateToAddEvent>(_navigateToAddTask);

    _connectivity = Connectivity().onConnectivityChanged.listen((results) {
      add(CheckInternetEvent(results: results));
    });

    add(const InitEvent());
  }

  @override
  Future<void> close() async {
    _connectivity.cancel();
    return super.close();
  }

  Future<void> _init(InitEvent event, Emitter<HomeState> emit) async {
    final UserModel user = await _getUserFromStorageUseCase.execute(
      const NoParams(),
    );

    if (!user.isEmpty()) {
      emit(state.copyWith(user: user));

      add(const GetAllTasksEvent());
    }
  }

  Future<void> _getAllTasks(
    GetAllTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final List<TaskModel> tasks = state.internetConnection
        ? await _getAllTasksUseCase.execute(state.user.uid)
        : await _getAllTasksLocalUseCase.execute(state.user.uid);

    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  Future<void> _addTask(AddTaskEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final List<TaskModel> tasks;

    if (state.internetConnection) {
      await _addTaskUseCase.execute(
        AddTaskParams(
          uid: state.user.uid,
          taskModel: event.task,
        ),
      );

      tasks = await _getAllTasksUseCase.execute(
        state.user.uid,
      );
    } else {
      await _addTaskLocalUseCase.execute(
        AddTaskParams(
          uid: state.user.uid,
          taskModel: event.task,
        ),
      );

      tasks = await _getAllTasksLocalUseCase.execute(
        state.user.uid,
      );
    }

    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  Future<void> _deleteTask(
    DeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final List<TaskModel> tasks;

    if (state.internetConnection) {
      await _deleteTaskUseCase.execute(
        DeleteTaskParams(
          uid: state.user.uid,
          taskId: event.taskId,
        ),
      );

      tasks = await _getAllTasksUseCase.execute(
        state.user.uid,
      );
    } else {
      await _deleteTaskLocalUseCase.execute(
        DeleteTaskParams(
          uid: state.user.uid,
          taskId: event.taskId,
        ),
      );

      tasks = await _getAllTasksLocalUseCase.execute(
        state.user.uid,
      );
    }

    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  Future<void> _updateTask(
    UpdateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final List<TaskModel> tasks;

    if (state.internetConnection) {
      await _updateTaskUseCase.execute(
        UpdateTaskParams(
          uid: state.user.uid,
          taskModel: event.task.copyWith(isCompleted: true),
        ),
      );

      tasks = await _getAllTasksUseCase.execute(
        state.user.uid,
      );
    } else {
      await _updateTaskLocalUseCase.execute(
        UpdateTaskParams(
          uid: state.user.uid,
          taskModel: event.task.copyWith(isCompleted: true),
        ),
      );

      tasks = await _getAllTasksLocalUseCase.execute(
        state.user.uid,
      );
    }

    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  Future<void> _synchronizeTasks(
    SyncTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await _syncTasksUseCase.execute(state.user.uid);

    final List<TaskModel> tasks = await _getAllTasksUseCase.execute(
      state.user.uid,
    );

    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  Future<void> _checkInternet(
    CheckInternetEvent event,
    Emitter<HomeState> emit,
  ) async {
    final bool connection = event.results.contains(ConnectivityResult.mobile) ||
            event.results.contains(ConnectivityResult.wifi) ||
            event.results.contains(ConnectivityResult.ethernet)
        ? true
        : false;

    add(const SyncTasksEvent());

    emit(
      state.copyWith(
        internetConnection: connection,
      ),
    );
  }

  Future<void> _navigateToAddTask(
    NavigateToAddEvent event,
    Emitter<HomeState> emit,
  ) async {
    _router.navigate(const AddTaskRoute());
  }

  Future<void> _signOut(SignOutEvent event, Emitter<HomeState> emit) async {
    emit(const HomeState.empty());

    _router.navigate(const AuthRoute());
  }
}
