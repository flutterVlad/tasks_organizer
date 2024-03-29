/// Entity of user.
class UserEntity {
  /// User identifier.
  final String uid;

  /// User email.
  final String email;

  /// User name.
  final String userName;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.userName,
  });

  /// Returns empty [UserEntity].
  const UserEntity.empty()
      : uid = '',
        email = '',
        userName = '';

  /// Converts `DocumentReference` to the [UserEntity].
  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        uid: json['uid'] ?? '',
        email: json['email'] ?? '',
        userName: json['userName'] ?? '',
      );

  /// Converts the [UserEntity] to [Map].
  Map<String, String> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }

  /// Checks if the user is empty.
  bool isEmpty() => this == const UserEntity.empty();

  @override
  bool operator ==(Object other) {
    return other is UserEntity &&
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
