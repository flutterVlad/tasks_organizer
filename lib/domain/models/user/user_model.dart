class UserModel {
  final String uid;
  final String email;
  final String userName;

  const UserModel({
    required this.uid,
    required this.email,
    required this.userName,
  });

  const UserModel.empty()
      : uid = '',
        email = '',
        userName = '';

  Map<String, String> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }

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
