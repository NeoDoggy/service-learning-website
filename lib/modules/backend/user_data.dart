import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';

class UserData {

  UserData({
    required this.uid,
    this.name,
    this.email,
    this.photoURL,
    this.studentId = 0,
    this.permission = UserPermission.normal
  });

  String uid;
  String? name;
  String? email;
  String? photoURL;
  int studentId;
  UserPermission permission;

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "email": email,
    "photoURL": photoURL,
    "studentId": studentId,
    "permission": permission.id,
  };

  factory UserData.fromUser(User user) => UserData(
    uid: user.uid,
    name: user.displayName,
    email: user.email,
    photoURL: user.photoURL,
  );

  factory UserData.fromJson(Map<String, dynamic> map) => UserData(
    uid: map["uid"],
    name: map["name"],
    email: map["email"],
    photoURL: map["photoURL"],
    studentId: (map["studentId"] ?? 0) as int,
    permission: UserPermission.fromId(map["permission"] ?? 0),
  );

  void combine(UserData userData) {
    name = name ?? userData.name;
    email = email ?? userData.email;
    photoURL = photoURL ?? userData.photoURL;
    studentId = (studentId == 0) ? userData.studentId : studentId;
    permission = (permission == UserPermission.normal) ? userData.permission : permission;
  }
}
