import '/domain/models/user/user_model.dart';
import '../entity/user/user_entity.dart';

class UserMapper {
  static UserModel toModel(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      userName: entity.userName,
      email: entity.email,
    );
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      uid: model.uid,
      userName: model.userName,
      email: model.email,
    );
  }
}
