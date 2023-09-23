
import 'package:flutter/material.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/string.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class view_pager_screen extends StatelessWidget {
  final PageController controller=PageController(initialPage: 0);

  view_pager_screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return  Container(
      color: Colors.white,
      child: Stack(
        children: [
          PageView(
            controller: controller,
            pageSnapping: true,
            children:  <Widget>[
              Component_App.ImageSlider(asset: 'assets/images/page_1.png',desc: string_app.sub_title1),
              Component_App.ImageSlider(asset: 'assets/images/page_2.png',desc: string_app.sub_title2),
              Component_App.ImageSlider(asset: 'assets/images/page_3.png',desc: string_app.sub_title3),
            ],

          ),
          Container(

              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                      controller: controller,  // PageController
                      count:  3,
                      effect:  const SlideEffect(
                        activeDotColor: ColorApp.blue,
                        dotColor: Colors.white,
                      ), // your preferred effect
                      onDotClicked: (index){

                      }
                  ),
                  const SizedBox(width: 150,),
                  GestureDetector(
                    onTap: (){
                      Navigator.popAndPushNamed(context, '/Create_Account');
                    },
                    child:const Text(
                      'تخطي',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          // remove under text { Line yellow}
                          decoration: TextDecoration.none

                      ),
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );

  }

}

