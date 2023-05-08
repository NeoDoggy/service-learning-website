import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/text/enhanced_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    this.width,
    this.height,
    required this.items,
    this.decorations,
    this.onDestinationSelected,
  });

  final double? width;
  final double? height;
  final List<String> items;
  final List<Widget?>? decorations;
  final void Function(int index)? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (int i = 0; i < items.length; i++)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  EnhancedText(
                    items[i],
                    style: const TextStyle(fontSize: 20),
                    onTap: () => onDestinationSelected?.call(i),
                  ),
                  if (decorations?[i] != null) const SizedBox(width: 20),
                  if (decorations?[i] != null) decorations![i]!,
                ],
              ),
              if (i < items.length - 1) const Divider(height: 20),
            ])
        ]),
      ),
    );
  }
}
