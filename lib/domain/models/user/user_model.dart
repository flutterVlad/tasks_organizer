/// Model of the user.
class UserModel {
  /// User identifier.
  final String uid;

  /// User email.
  final String email;

  /// User name.
  final String userName;

  const UserModel({
    required this.uid,
    required this.email,
    required this.userName,
  });

  /// Returns empty [UserModel].
  const UserModel.empty()
      : uid = '',
        email = '',
        userName = '';

  /// Converts the [UserModel] to [Map].
  Map<String, String> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }

  /// Checks if the user is empty.
  bool isEmpty() => this == const UserModel.empty();

  @override
  bool operator ==(Object other) {
    return other is UserModel &&
        uid == other.uid &&
        userName == other.userName &&
        email == other.email;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      uid,
      userName,
      email,
    );
  }
}
