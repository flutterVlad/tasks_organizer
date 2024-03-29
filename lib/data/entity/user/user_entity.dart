class UserEntity {
  final String uid;
  final String email;
  final String userName;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.userName,
  });

  const UserEntity.empty()
      : uid = '',
        email = '',
        userName = '';

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        uid: json['uid'] ?? '',
        email: json['email'] ?? '',
        userName: json['userName'] ?? '',
      );

  Map<String, String> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }

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
