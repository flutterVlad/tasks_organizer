import 'package:hive_flutter/hive_flutter.dart';

import '../entity/user/user_entity.dart';

class HiveProvider {
  Future<void> saveUser({required UserEntity userEntity}) async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    await userBox.add(userEntity);
  }

  Future<UserEntity> getUser() async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    return userBox.isNotEmpty ? userBox.values.first : const UserEntity.empty();
  }

  Future<void> deleteUser() async {
    final Box<UserEntity> userBox = await Hive.openBox('user');

    await userBox.clear();
  }
}
