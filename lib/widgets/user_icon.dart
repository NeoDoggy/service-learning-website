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
  final _db = FirebaseFirestore.instance;

  bool _isHover = false;

  List<PopupMenuEntry<dynamic>> _menu = [];
  ImageProvider<Object>? _image;
  UserData? _userData;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      _updateUserData(user);
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
            foregroundImage: _image,
          ),
        ),
      ),
    );
  }

  void _updateMenu() {
    final String name = _userData?.name ?? "<name>";
    final String email = _userData?.name ?? "<email>";
    final String permission = _userData?.permission.name ?? "<permission>";

    // 沒登入顯示的 menu
    if (_userData == null) {
      setState(() {
        _menu = [
          PopupMenuItem(
            onTap: () => AuthService().signInWithGoogle(),
            child: const Text("登入")
          ),
        ];
      });
    }
    // 有登入顯示的 menu
    else {
      setState(() {
        _menu = [
          PopupMenuItem(
            child: Row(
              children: [
                Text(name),
                const SizedBox(width: 10),
                Text(email),
              ],
            )
          ),
          PopupMenuItem(child: Text("身份：$permission")),
          const PopupMenuDivider(height: 10),
          PopupMenuItem(
            onTap: () {
              _auth.signOut();
              // context.go(MyRouter.root);
            },
            child: const Text("登出")
          ),
        ];
      });
    }
  }

  void _updateImage() {
    final String? photoURL = _userData?.photoURL;

    // 沒登入顯示的 icon
    if (photoURL == null) {
      setState(() {
        _image = IconImage(
          icon: Icons.person,
          background: Colors.grey,
          color: Colors.white
        );
      });
    }
    // 有登入顯示的 icon
    else {
      setState(() {
        _image = NetworkImage(photoURL);
      });
    }
  }

  void _updateUserData(User? user) async {
    if (user == null) {
      _updateMenu();
      _updateImage();
      return;
    }

    final doc = _db.collection("users").doc(user.uid);
    doc.get().then((value) {
      final data = value.data();
      setState(() {
        _userData = (data == null) ?
          UserData.fromUser(user) : UserData.fromJson(data);
        _userData!.update(UserData.fromUser(user));
      });
      doc.set(_userData!.toJson());
      _updateMenu();
      _updateImage();
    });
  }
}

