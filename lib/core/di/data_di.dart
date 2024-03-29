import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/data/data.dart';
import '/navigation/app_router/app_router.dart';
import '../firebase_options.dart';

final GetIt appLocator = GetIt.instance;
final DataDI dataDI = DataDI();

class DataDI {
  late final FirebaseFirestore _firebaseFirestore;
  late final FirebaseAuth _firebaseAuth;

  Future<void> initDependencies() async {
    await _initFirebase();
    await _initHive();
    _firebaseFirestore = _initFirestore();
    _firebaseAuth = _initFirebaseAuth();
    _initNavigation();
    _initAuth();
    _initTasks();
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(UserAdapter());
  }

  FirebaseFirestore _initFirestore() => FirebaseFirestore.instance;

  FirebaseAuth _initFirebaseAuth() => FirebaseAuth.instance;

  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  void _initNavigation() {
    appLocator.registerSingleton(AppRouter());
  }

  void _initAuth() {
    appLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authProvider: appLocator.get<AuthProvider>(),
        hiveProvider: appLocator.get<HiveProvider>(),
      ),
    );

    appLocator.registerLazySingleton<AuthProvider>(
      () => AuthProvider(
        firebaseAuth: _firebaseAuth,
        firestoreProvider: appLocator.get<FirestoreProvider>(),
        hiveProvider: appLocator.get<HiveProvider>(),
      ),
    );

    appLocator.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GetUserFromStorageUseCase>(
      () => GetUserFromStorageUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );
  }

  void _initTasks() {
    appLocator.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(
        firestoreProvider: appLocator.get<FirestoreProvider>(),
        hiveProvider: appLocator.get<HiveProvider>(),
      ),
    );

    appLocator.registerLazySingleton<HiveProvider>(
      () => HiveProvider(),
    );

    appLocator.registerLazySingleton<FirestoreProvider>(
      () => FirestoreProvider(
        firebaseFirestore: _firebaseFirestore,
      ),
    );

    appLocator.registerLazySingleton<SyncTasksUseCase>(
      () => SyncTasksUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<AddTaskUseCase>(
      () => AddTaskUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<AddTaskLocalUseCase>(
      () => AddTaskLocalUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<DeleteTaskLocalUseCase>(
      () => DeleteTaskLocalUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<UpdateTaskUseCase>(
      () => UpdateTaskUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<UpdateTaskLocalUseCase>(
      () => UpdateTaskLocalUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GetAllTasksUseCase>(
      () => GetAllTasksUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );

    appLocator.registerLazySingleton<GetAllTasksLocalUseCase>(
      () => GetAllTasksLocalUseCase(
        taskRepository: appLocator.get<TaskRepository>(),
      ),
    );
  }
}
