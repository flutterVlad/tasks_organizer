import 'package:hive_flutter/hive_flutter.dart';
import '/core/hive_adapters_id/adapters_id.dart';
import 'user_entity.dart';

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  int get typeId => AdaptersId.user;

  @override
  UserEntity read(BinaryReader reader) {
    final int fieldsCount = reader.readByte();
    Map<String, String> data = {};
    for (int i = 0; i < fieldsCount; i++) {
      final String key = reader.readString();
      final value = reader.read();
      data[key] = value;
    }

    return UserEntity.fromJson(data);
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer.writeByte(3);
    writer.writeString('uid');
    writer.write(obj.uid);
    writer.writeString('userName');
    writer.write(obj.userName);
    writer.writeString('email');
    writer.write(obj.email);
  }
}
