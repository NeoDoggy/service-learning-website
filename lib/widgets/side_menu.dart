import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/enhanced_text.dart';

class SideMenu extends StatelessWidget {

  const SideMenu({
    super.key,
    required this.items,
    this.onDestinationSelected,
  });

  final List<String> items;
  final void Function(int)? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.only(
        left: 30, right: 30, top: 20, bottom: 20
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < items.length; i ++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EnhancedText(items[i],
                  style: const TextStyle(fontSize: 20),
                  onTap: () => onDestinationSelected?.call(i),
                ),
                if (i < items.length - 1)
                  const Divider(height: 20),
              ]
            )
        ]
      ),
    );
  }
}