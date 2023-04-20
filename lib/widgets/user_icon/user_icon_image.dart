import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/icon_image.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class UserIconImage extends StatefulWidget {

  const UserIconImage({
    super.key,
    required this.size,
    required this.hoverBorderColor,
    required this.hoverBorderWidth,
  });

  final double size;
  final Color hoverBorderColor;
  final double hoverBorderWidth;

  @override
  State<UserIconImage> createState() => _UserIconImageState();
}

class _UserIconImageState extends State<UserIconImage> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {

    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ImageProvider<Object> image;

    // 沒登入顯示的 image
    if (!authProvider.isAuthed) {
      image = IconImage(
          icon: Icons.person,
          background: Colors.grey,
          color: Colors.white
      );
    }
    // 有登入顯示的 image
    else {
      image = NetworkImage(authProvider.userData?.photoURL ?? "");
    }

    return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _isHovered ? widget.hoverBorderColor : Colors.transparent,
              width: widget.hoverBorderWidth
            ),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: widget.size,
            foregroundImage: image,
          ),
        )
    );
  }
}