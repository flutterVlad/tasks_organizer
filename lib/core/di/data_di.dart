import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
  }

  FirebaseFirestore _initFirestore() => FirebaseFirestore.instance;

  FirebaseAuth _initFirebaseAuth() => FirebaseAuth.instance;

  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  FirebaseAuth get firebaseAuth => _firebaseAuth;
}
