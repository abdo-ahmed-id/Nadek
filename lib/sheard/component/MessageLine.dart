import 'dart:ui';

import 'package:flutter/material.dart';

class MessageLine extends StatelessWidget {
  MessageLine({Key? key,required this.sender, required this.text,required this.imageUrl}) : super(key: key);
  final String? sender;
  final String? text;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(sender! ,style: TextStyle(fontSize: 12 , color: Colors.white) ,),
                  ClipRect(

                    child: Material(
                        elevation: 0,
                        borderRadius:const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),


                        ),
                        color: Colors.black12.withOpacity(0.1),

                        child:Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20),
                          child: Text(text! , style: TextStyle(fontSize: 16 , color: Colors.white ),),
                        )
                    ),
                  ),
                ],
              ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 0,
              child:  CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(imageUrl!),
                radius: 30,
              ),

          ),



        ],
      ),
    );
  }
}