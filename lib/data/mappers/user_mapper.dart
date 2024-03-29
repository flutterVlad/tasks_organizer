import '/domain/models/user/user_model.dart';
import '../entity/user/user_entity.dart';

/// Converter for [UserEntity] and [UserModel] objects.
class UserMapper {
  /// Converts a [UserEntity] to a [UserModel].
  static UserModel toModel(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      userName: entity.userName,
      email: entity.email,
    );
  }

  /// Converts a [UserModel] to a [UserEntity].
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      uid: model.uid,
      userName: model.userName,
      email: model.email,
    );
  }
}
