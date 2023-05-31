import 'package:flutter/material.dart';

class Asking_question_form extends StatelessWidget 
{
  const Asking_question_form({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (

      width: 260.0,
      height: 138.0,

      decoration: BoxDecoration
      (
        color: const Color(0xFF0A2472),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Stack 
      ( 
        children: 
        [
          const Positioned
          (
            left: 22.0,
            top: 19.0,

            child: Center
            (
              child: Text
              (
                '找不到想問的問題？',
                style: TextStyle
                (
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            )
          ),

          Positioned
          (
            left: 47.0,
            top: 66.0,

            child: Container
            (
              width: 166.0,
              height: 49.0,
              
              decoration: BoxDecoration
              (
                color: const Color(0xFFF2F4FF),
                borderRadius: BorderRadius.circular(30),
              ),

              child: const Center
              (
                child: Text
                (
                  '提問表單',
                  style: TextStyle
                  (
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ]
      )
    );             
  }
}