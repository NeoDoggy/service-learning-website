import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  bool _isHover = false;

  List<PopupMenuEntry<dynamic>> _menu = [];
  ImageProvider<Object>? _icon;

  @override
  void initState() {
    super.initState();
    _menu = _generateMenu();
    _icon = _generateIcon();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
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
    if (FirebaseAuth.instance.currentUser != null) {
      return [
        PopupMenuItem(
          child: Row(
            children: [
              Text(FirebaseAuth.instance.currentUser?.displayName ?? "<name>"),
              const SizedBox(width: 10),
              Text(FirebaseAuth.instance.currentUser?.email ?? "<email>"),
            ],
          )
        ),
        const PopupMenuDivider(height: 10),
        PopupMenuItem(
          onTap: () => FirebaseAuth.instance.signOut(),
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
    if (FirebaseAuth.instance.currentUser != null) {
      return NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? "");
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
}
