class UserModel {
  final String displayName;
  final String email;
  final String uid;
  UserModel(
      {required this.displayName, required this.email, required this.uid});
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'displayName': displayName};
  }

  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
        displayName: doc['displayName'], email: doc['email'], uid: doc['uid']);
  }
}
