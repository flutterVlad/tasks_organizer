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
}
