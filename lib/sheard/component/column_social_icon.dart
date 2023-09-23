import 'package:flutter/material.dart';
import 'package:nadek/sheard/style/ColorApp.dart';

Widget getAlbum(albumImg) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      // shape: BoxShape.circle,
      // color: black
    ),
    child: Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        ),
        Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        albumImg),
                    fit: BoxFit.cover)),
          ),
        )
      ],
    ),
  );
}

Widget getIcons(icon, count, size,Function() function) {
  return Container(

    child: Column(
      children: <Widget>[
       IconButton(
           onPressed: function,
           icon:Image(
               height: 30,
               width: 30,
               image: AssetImage(icon),
               color:  Colors.white
           )
       ),
        SizedBox(
          height: 5,
        ),
        Text(
          count,
          style: TextStyle(
              color:  Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
        )
      ],
    ),
  );
}
Widget getIconsLike({required icon,required count,required size,required Function() function}) {
  return Container(

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       IconButton(
            onPressed: function,
            icon: icon
        ),

        Padding(
            padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
          child: Text(
            count,
            style: TextStyle(
                color:  Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          ),

        )

      ],
    ),
  );
}

Widget getProfile(img, {required Function() function,required Function() profileClick}) {
  return GestureDetector(
    onTap:profileClick  ,
    child: Container(
      width: 60,
      height: 60,
      child: Stack(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color:  Colors.white),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        img),
                    fit: BoxFit.cover)),
          ),
          Positioned(
              bottom: 3,
              left: 18,
              child: Container(
                  width: 20,
                  height: 20,
                  decoration:
                  BoxDecoration(shape: BoxShape.circle, color:  ColorApp.move),
                  child:  GestureDetector(
                    onTap: function,
                    child: Icon(Icons.add,color: Colors.white,size: 10,),
                  )
              ))
        ],
      ),
    ),
  );
}