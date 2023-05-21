import 'package:flutter/material.dart';

class ChoosableText extends StatelessWidget {

  const ChoosableText({
    super.key,
    required this.defaultIndex,
    required this.items,
    this.onSelected,
    this.disabledIndex = const [],
  });

  final int defaultIndex;
  final List<String> items;
  final void Function(int)? onSelected;
  final List<int> disabledIndex;

  @override
  Widget build(BuildContext context) {
  
    List<PopupMenuEntry<dynamic>> menu = [
      for (int i = 0; i < items.length; i ++)
        PopupMenuItem(
          onTap: () {
            if (onSelected != null) {
              onSelected!(i);
            }
          },
          enabled: i != defaultIndex && !disabledIndex.contains(i),
          child: Text(items[i])
        ),
    ];

    return InkWell(
      onTap: () {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset offset = box.localToGlobal(Offset.zero);
        showMenu(
          context: context,
          position: RelativeRect.fromSize(
              offset.translate(0, box.size.height + 10) &
                  Size(box.size.width, 0),
              MediaQuery.of(context).size
          ),
          items: menu,
        );
      },
      child: SelectionContainer.disabled(child: Text(items[defaultIndex])),
    );
  }
}