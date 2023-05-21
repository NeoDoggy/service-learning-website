import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user/user_permission.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/widgets/user_icon/user_icon_image.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    super.key,
    required this.size,
    this.hoverBorderColor = Colors.black26,
    this.hoverBorderWidth = 6,
  });

  final double size;
  final Color hoverBorderColor;
  final double hoverBorderWidth;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String name = authProvider.userData?.name ?? "<name>";
    String email = authProvider.userData?.email ?? "<email>";

    List<PopupMenuEntry<dynamic>> menu = [
      // 沒登入顯示的 menu
      if (!authProvider.isAuthed)
        PopupMenuItem(
            // onTap: () => authProvider.signInWithGoogle(),
            onTap: () => context.push("/${MyRouter.login}"),
            child: const Text("登入")),

      // 有登入顯示的 menu
      if (authProvider.isAuthed)
        PopupMenuItem(
          onTap: () => context.push(
              authProvider.userData!.permission >= UserPermission.student
                  ? "/${MyRouter.admin}"
                  : "/${MyRouter.backstage}"),
          // 這東西最多只能顯示 31 個字
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_cutdown(name, 31)),
              Text(_cutdown(email, 31)),
            ],
          ),
        ),
      if (authProvider.isAuthed) const PopupMenuDivider(height: 10),
      if (authProvider.isAuthed)
        PopupMenuItem(
            onTap: () async {
              await authProvider.signOut();
              if (context.mounted) {
                context.go("/");
              }
            },
            child: const Text("登出")),
    ];

    return SizedBox(
      height: size + hoverBorderWidth * 2,
      width: size + hoverBorderWidth * 2,
      child: GestureDetector(
          onTap: () {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final Offset offset = box.localToGlobal(Offset.zero);
            showMenu(
              context: context,
              position: RelativeRect.fromSize(
                  offset.translate(0, box.size.height + 10) &
                      Size(box.size.width, 0),
                  MediaQuery.of(context).size),
              items: menu,
            );
          },
          child: UserIconImage(
              size: size,
              hoverBorderColor: hoverBorderColor,
              hoverBorderWidth: hoverBorderWidth)),
    );
  }

  String _cutdown(String str, int n) {
    if (str.length <= n) {
      return str;
    }
    return "${str.substring(0, n - 3)}...";
  }
}
