import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../firebase_options.dart';

final GetIt appLocator = GetIt.instance;
final DataDI dataDI = DataDI();

class DataDI {
  Future<void> initDependencies() async {
    await _initFirebase();
    await _initHive();
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
  }
}
