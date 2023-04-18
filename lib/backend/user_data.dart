
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_learning_website/backend/user_permission.dart';

class UserData {

  UserData({
    required this.uid,
    required this.name,
    required this.email,
    this.studentId = 0,
    this.permission = UserPermission.normal
  });

  String uid;
  String? name;
  String? email;
  int studentId;
  UserPermission permission;

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "email": email,
    "studentId": studentId,
    "permission": permission.id,
  };

  factory UserData.fromUser(User user) => UserData(
    uid: user.uid,
    name: user.displayName,
    email: user.email,
  );

  factory UserData.fromJson(Map<String, dynamic> map) => UserData(
    uid: map["uid"],
    name: map["name"],
    email: map["email"],
    studentId: (map["studentId"] ?? 0) as int,
    permission: UserPermission.fromId(map["permission"] ?? 0),
  );

  void combine(UserData userData) {
    name = name ?? userData.name;
    email = email ?? userData.email;
    studentId = (studentId == 0) ? userData.studentId : studentId;
    permission = (permission == UserPermission.none) ? userData.permission : permission;
  }
}
