import 'package:flutter/material.dart';

class Course_card extends StatelessWidget 
{
  const Course_card({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      width: 350.0,
      height: 469.0,

      decoration: BoxDecoration
      (
        color: const Color(0xFFD6E4FF),
        borderRadius: BorderRadius.circular(30),
      ),      
      
      child: Stack 
      (
        children: 
        [
          Positioned
          (        
            child: Container
            (
              width: 350.0,
              height: 200.0,

              decoration: const BoxDecoration
              (                
                borderRadius: BorderRadius.only
                (
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                  
                image: DecorationImage
                (
                  image: AssetImage('assets/images/squirrel.png'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          Positioned
          (
            left: 20.0,
            top: 20.84,

            child: Container
		        (
              width: 117.0,
              height: 32.31,

              decoration: BoxDecoration
		          (
                color: const Color(0xFF4EAAFA),
                borderRadius: BorderRadius.circular(30),
              ),

              child: const Center
		          (
                child: Text
   		          (
                  '03/26 截止',
                  style: TextStyle
        		      (
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal, 
                  ),
                ),
              ),
            ),
          ),

          const Positioned
          (
            left: 30.0,
            top: 230.0,

            child: Center
            (
              child: Text
              (
                'Python 程式設計體驗營',
                style: TextStyle
                (
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            )
          ),

          const Positioned
          (
            left: 100.0,
            top: 284.0,

            child: Center
            (
              child: Text
              (
                '4/8起，共 6 堂課',
                style: TextStyle
                (
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ),

          const Positioned
          (
            left: 100.0,
            top: 332.0,

            child: Center
            (
              child: Text
              (
                '中央大學\n工程二館 219 教室',
                style: TextStyle
                (
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ),

          const Positioned
          (
            left: 100.0,
            top: 404.0,

            child: Center
            (
              child: Text
              (
                '國高中職生',
                style: TextStyle
                (
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ),

          Positioned
          (
            left: 30.0,
            top: 279.0,

            child: Container
            (
              width: 40.0,
              height: 40.0,

              decoration: const BoxDecoration
              (
                shape: BoxShape.circle,
                image: DecorationImage
                (
                  image: AssetImage('assets/images/calender.png'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned
          (
            left: 30.0,
            top: 339.0,

            child: Container
            (
              width: 40.0,
              height: 40.0,

              decoration: const BoxDecoration
              (
                image: DecorationImage
                (
                  image: AssetImage('assets/images/locationmark.png'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned
          (
            left: 30.0,
            top: 399.0,

            child: Container
            (
              width: 40.0,
              height: 40.0,

              decoration: const BoxDecoration
              (
                image: DecorationImage
                (
                  image: AssetImage('assets/images/object.png'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}