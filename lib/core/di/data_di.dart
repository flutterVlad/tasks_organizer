import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/data/data.dart';
import '/navigation/app_router/app_router.dart';
import '../firebase_options.dart';

/// Instance of [GetIt] for [DataDI].
final GetIt appLocator = GetIt.instance;

/// Instance of [DataDI].
final DataDI dataDI = DataDI();

/// Global service locator for business logic.
class DataDI {
  /// Instance of [FirebaseFirestore].
  late final FirebaseFirestore _firebaseFirestore;

  /// Instance of [FirebaseAuth].
  late final FirebaseAuth _firebaseAuth;

  /// Initializes main app's dependencies.
  Future<void> initDependencies() async {
    await _initFirebase();
    await _initHive();
    _firebaseFirestore = _initFirestore();
    _firebaseAuth = _initFirebaseAuth();
    _initNavigation();
    _initAuth();
    _initTasks();
  }

  /// Initializes [Firebase].
  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Initializes [Hive] and Hive adapters.
  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(UserAdapter());
  }

  /// Setup [FirebaseFirestore] instance.
  FirebaseFirestore _initFirestore() => FirebaseFirestore.instance;

  /// Setup [FirebaseAuth] instance.
  FirebaseAuth _initFirebaseAuth() => FirebaseAuth.instance;

  /// Returns [_firebaseFirestore];
  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  /// Returns [_firebaseAuth];
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  /// Initializes [AppRouter] instance.
  void _initNavigation() {
    appLocator.registerSingleton(AppRouter());
  }

  /// Initializes everything related to authentication.
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

  /// Initializes everything related to tasks.
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
