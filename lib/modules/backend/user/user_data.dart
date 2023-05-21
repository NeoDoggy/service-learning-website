import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';

class UserData {
  UserData({
    required this.uid,
    this.name = "",
    this.email = "",
    this.photoURL = "",
    this.studentId = 0,
    this.permission = UserPermission.normal,
    List<String>? joinedCourses,
    List<String>? joinedActivities,
  })  : joinedCourses = joinedCourses ?? [],
        joinedActivities = joinedActivities ?? [];

  String uid;
  String name;
  String email;
  String photoURL;
  int studentId;
  UserPermission permission;
  List<String> joinedCourses;
  List<String> joinedActivities;

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "photoURL": photoURL,
        "studentId": studentId,
        "permission": permission.id,
        "joinedCourses": joinedCourses,
        "joinedActivities": joinedActivities,
      };

  factory UserData.fromUser(User user) => UserData(
        uid: user.uid,
        name: user.displayName ?? "<name>",
        email: user.email ?? "<email>",
        photoURL: user.photoURL ?? "<photoURL>",
      );

  factory UserData.fromJson(Map<String, dynamic> map) => UserData(
        uid: map["uid"],
        name: map["name"] ?? "",
        email: map["email"] ?? "",
        photoURL: map["photoURL"] ?? "",
        studentId: (map["studentId"] ?? 0) as int,
        permission: UserPermission.fromId(map["permission"] ?? 0),
        joinedCourses:
            (map["joinedCourses"] as List?)?.map((e) => e.toString()).toList(),
        joinedActivities: (map["joinedActivities"] as List?)
            ?.map((e) => e.toString())
            .toList(),
      );

  void combine(UserData userData) {
    name = (name == "") ? userData.name : name;
    email = (email == "") ? userData.email : email;
    photoURL = (photoURL == "") ? userData.photoURL : photoURL;
    studentId = (studentId == 0) ? userData.studentId : studentId;
    permission = (permission == UserPermission.normal)
        ? userData.permission
        : permission;
    joinedCourses =
        (joinedCourses.isEmpty) ? userData.joinedCourses : joinedCourses;
    joinedActivities = (joinedActivities.isEmpty)
        ? userData.joinedActivities
        : joinedActivities;
  }
}
