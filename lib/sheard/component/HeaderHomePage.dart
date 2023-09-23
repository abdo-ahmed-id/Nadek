
import 'package:flutter/material.dart';

class HeaderHomePage extends StatelessWidget {
  bool repalce =false;
  Function() TrendClick;
  Function() PraivteClick;
   HeaderHomePage({
    required this.repalce,
     required this.PraivteClick,
     required this.TrendClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: TrendClick,
          child: Text(
            "ترند",
            style: TextStyle(
              color: repalce ?Colors.white:Colors.white.withOpacity(0.3),
              fontSize: 16,
              shadows: [
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  color: repalce? Colors.black:Colors.transparent
                )
              ]
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "|",
          style: TextStyle(
            color:  Colors.white.withOpacity(0.3),
            fontSize: 17,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: PraivteClick,
          child:  Text(
            "خاص",
            style: TextStyle(
                color: repalce?Colors.white.withOpacity(0.7):Colors.white ,
                fontSize: 17, fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      color:repalce? Colors.transparent:Colors.black
                  )
                ]
            ),
          ),
        )
      ],
    );
  }
}