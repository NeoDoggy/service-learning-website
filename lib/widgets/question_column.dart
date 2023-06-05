import 'package:flutter/material.dart';

class Question_column extends StatelessWidget 
{
  const Question_column({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      width: 880.0,
      height: 80.0,
              
      decoration: BoxDecoration
      (
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all
        (
          color: const Color(0xFF0E6BA8),
          width: 5.0,
        ),
      ),

      child: Stack
      (
        children: 
        const [
          Positioned
          (
            left: 36.3,
            top: 15.0,

            child: Text
            (
              'Question',
              style: TextStyle
              (
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          ),

          Positioned
          (
            left: 820.0,
            top: 7.0,

            child: Icon
            (
              Icons.arrow_right, 
              size: 60,          
              color: Colors.grey, 
            ),
          ),
        ]
      )
    );      
  }
}