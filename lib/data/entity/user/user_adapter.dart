import 'package:hive_flutter/hive_flutter.dart';
import '/core/hive_adapters_id/adapters_id.dart';
import 'user_entity.dart';

class UserAdapter extends TypeAdapter<UserEntity> {
  @override
  int get typeId => AdaptersId.user;

  @override
  UserEntity read(BinaryReader reader) {
    final String uid = reader.readString();
    final String userName = reader.readString();
    final String email = reader.readString();

    return UserEntity(
      uid: uid,
      email: email,
      userName: userName,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer.writeString(obj.uid);
    writer.writeString(obj.userName);
    writer.writeString(obj.email);
  }
}
