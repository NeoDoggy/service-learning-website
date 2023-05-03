import 'package:flutter/material.dart';

class OpinonCard extends StatelessWidget {
  const OpinonCard({
    super.key,
    required this.said,
  });

  final String said;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      color: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 100,
        width: 600,
        child: Row(
          children: [
            const Icon(Icons.account_circle_outlined,color: Color(0xFF000000),size: 64,),
            const SizedBox(width: 20,),
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              color: const Color(0xFFF0F8FF),
              elevation: 0,
              child: SizedBox(
                width: 500,
                height: 96,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 32),
                  child: Text(
                    said,
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 24
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
