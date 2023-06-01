import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/side_menu.dart';


class Question_menu extends StatelessWidget 
{
  const Question_menu({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      width: 260.0,
      height: 101.0,

      decoration: BoxDecoration
      (
        color: const Color(0xFFF2F4FF),
        borderRadius: BorderRadius.circular(50),
      ),

      child: const Center
      (
        child: Text
        (
          '常見問題',
          style: TextStyle
          (
            fontSize: 48,
            color: Colors.black,
          ),
        ),
      ),         
    );          
  }
}