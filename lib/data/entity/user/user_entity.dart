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
}
