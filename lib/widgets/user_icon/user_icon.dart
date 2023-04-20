import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
    List<PopupMenuEntry<dynamic>> menu = [
      // 沒登入顯示的 menu
      if (!authProvider.isAuthed)
        PopupMenuItem(
            // onTap: () => authProvider.signInWithGoogle(),
            onTap: () => context.push(MyRouter.login),
            child: const Text("登入")),

      // 有登入顯示的 menu
      if (authProvider.isAuthed)
        PopupMenuItem(
            child: Row(
          children: [
            Text(authProvider.userData?.name ?? "<name>"),
            const SizedBox(width: 10),
            Text(authProvider.userData?.email ?? "<email>"),
          ],
        )),
      if (authProvider.isAuthed) const PopupMenuDivider(height: 10),
      if (authProvider.isAuthed)
        PopupMenuItem(
            onTap: () async {
              await authProvider.signOut();
              if (context.mounted) {
                context.go(MyRouter.root);
              }
            },
            child: const Text("登出")),
    ];

    return GestureDetector(
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
            hoverBorderWidth: hoverBorderWidth));
  }
}
