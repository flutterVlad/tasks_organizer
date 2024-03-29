import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/usecases/export_usecases.dart';
import '/features/auth/bloc/auth_bloc.dart';
import '/features/home/bloc/home_bloc.dart';
import '/core/di/data_di.dart';
import 'navigation/app_router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dataDI.initDependencies();

  runApp(const TasksOrganizer());
}

class TasksOrganizer extends StatelessWidget {
  const TasksOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(
            getAllTasksUseCase: appLocator.get<GetAllTasksUseCase>(),
            getAllTasksLocalUseCase: appLocator.get<GetAllTasksLocalUseCase>(),
            getUserFromStorageUseCase:
                appLocator.get<GetUserFromStorageUseCase>(),
            addTaskUseCase: appLocator.get<AddTaskUseCase>(),
            addTaskLocalUseCase: appLocator.get<AddTaskLocalUseCase>(),
            updateTaskUseCase: appLocator.get<UpdateTaskUseCase>(),
            updateTaskLocalUseCase: appLocator.get<UpdateTaskLocalUseCase>(),
            deleteTaskUseCase: appLocator.get<DeleteTaskUseCase>(),
            deleteTaskLocalUseCase: appLocator.get<DeleteTaskLocalUseCase>(),
            syncTasksUseCase: appLocator.get<SyncTasksUseCase>(),
            router: appLocator.get<AppRouter>(),
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
            signInUseCase: appLocator.get<SignInUseCase>(),
            signUpUseCase: appLocator.get<SignUpUseCase>(),
            getUserFromStorageUseCase:
                appLocator.get<GetUserFromStorageUseCase>(),
            router: appLocator.get<AppRouter>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Tasks Organizer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appLocator.get<AppRouter>().config(),
      ),
    );
  }
}
