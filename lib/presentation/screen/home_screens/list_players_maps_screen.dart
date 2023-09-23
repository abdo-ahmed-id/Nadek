import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../sheard/style/ColorApp.dart';

class ListPlayerMapsScreen extends StatelessWidget {
  const ListPlayerMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "الأردن - الزرقاء الجديدة",
            ),
            SvgPicture.asset("assets/icons/location.svg")
          ],
        ),
        elevation: 0,
        backgroundColor: ColorApp.black_400,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
