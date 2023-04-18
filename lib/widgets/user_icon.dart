import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_learning_website/backend/user_data.dart';
import 'package:service_learning_website/services/auth_service.dart';
import 'package:service_learning_website/modules/icon_image.dart';

class UserIcon extends StatefulWidget {

  final double size;
  final Color hoverBorderColor;
  final double hoverBorderWidth;

  const UserIcon({
    super.key,
    required this.size,
    this.hoverBorderColor = Colors.black26,
    this.hoverBorderWidth = 6,
  });

  @override
  State<UserIcon> createState() => _UserIconState();
}

class _UserIconState extends State<UserIcon> {

  final _auth = FirebaseAuth.instance;
  final _userColl = FirebaseFirestore.instance.collection("users");

  bool _isHover = false;

  List<PopupMenuEntry<dynamic>> _menu = [];
  ImageProvider<Object>? _icon;
  UserData? _userData;

  @override
  void initState() {
    super.initState();
    _menu = _generateMenu();
    _icon = _generateIcon();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _updateUserData(user);
        _menu = _generateMenu();
        _icon = _generateIcon();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset offset = box.localToGlobal(Offset.zero);
        showMenu(
          context: context,
          position: RelativeRect.fromSize(
            offset.translate(0, box.size.height + 10) & Size(box.size.width, 0),
            MediaQuery.of(context).size
          ),
          items: _menu,
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _isHover ? widget.hoverBorderColor : Colors.transparent,
              width: widget.hoverBorderWidth
            ),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: widget.size,
            foregroundImage: _icon,
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> _generateMenu() {
    // 有登入顯示的 menu
    if (_auth.currentUser != null) {
      return [
        PopupMenuItem(
          child: Row(
            children: [
              Text(_auth.currentUser?.displayName ?? "<name>"),
              const SizedBox(width: 10),
              Text(_auth.currentUser?.email ?? "<email>"),
            ],
          )
        ),
        PopupMenuItem(child: Text("身份：${_userData?.permission.name ?? '<permission>'}")),
        const PopupMenuDivider(height: 10),
        PopupMenuItem(
          onTap: () {
            _auth.signOut();
            // context.go(MyRouter.root);
          },
          child: const Text("登出")
        ),
      ];
    }
    // 沒登入顯示的 menu
    else {
      return [
        PopupMenuItem(
          onTap: () => AuthService().signInWithGoogle(),
          child: const Text("登入")
        ),
      ];
    }
  }

  ImageProvider<Object> _generateIcon() {
    // 有登入顯示的 icon
    if (_auth.currentUser != null) {
      return NetworkImage(_auth.currentUser?.photoURL ?? "");
    }
    // 沒登入顯示的 icon
    else {
      return IconImage(
        icon: Icons.person,
        color: Colors.grey,
        background: Colors.white
      );
    }
  }

  void _updateUserData(User? user) {
    if (user == null) return;
    final uidDoc = _userColl.doc(user.uid);
    uidDoc.snapshots().map((doc) => doc.data()).listen((map) {
      _userData = (map == null) ?
        UserData.fromUser(user) : UserData.fromJson(map);
      _userData!.combine(UserData.fromUser(user));
      uidDoc.set(_userData!.toJson());
    });
  }
}

