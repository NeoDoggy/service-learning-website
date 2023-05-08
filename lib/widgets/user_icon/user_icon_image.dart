import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  ImageProvider<Object>? _image;
  Uint8List? _imageByte;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor:
            _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    _isHovered ? widget.hoverBorderColor : Colors.transparent,
                width: widget.hoverBorderWidth),
            shape: BoxShape.circle,
          ),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              // 有登入顯示的 image
              if (_imageByte == null && authProvider.isAuthed) {
                http
                    .get(Uri.parse(authProvider.userData!.photoURL))
                    .timeout(const Duration(seconds: 5))
                    .then((response) =>
                        setState(() => _imageByte = response.bodyBytes))
                    .catchError((_) => setState(() => _imageByte = null));
              }
              if (_imageByte != null) {
                _image = MemoryImage(_imageByte!);
              }
              // 沒登入顯示的 image
              else {
                _image = IconImage(
                    icon: Icons.person,
                    background: Colors.grey,
                    color: Colors.white);
              }

              return CircleAvatar(
                radius: widget.size,
                foregroundImage: _image,
              );
            },
          ),
        ));
  }
}
