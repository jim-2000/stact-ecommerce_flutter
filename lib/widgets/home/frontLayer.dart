import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';

class FrontLayer extends StatelessWidget {
  const FrontLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _carouselImg = [
      Image.asset("assets/images/carousel1.png"),
      Image.asset("assets/images/carousel2.jpeg"),
      Image.asset("assets/images/carousel3.jpeg"),
      Image.asset("assets/images/carousel4.png"),
    ];
    final List<Widget> _swiperImages = [
      Image.asset("assets/images/carousel1.png"),
      Image.asset("assets/images/carousel2.jpeg"),
      Image.asset("assets/images/carousel3.jpeg"),
      Image.asset("assets/images/carousel4.png"),
    ];
    return ListView(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: Carousel(
            images: _carouselImg,
            animationDuration: Duration(seconds: 3),
            animationCurve: Curves.fastOutSlowIn,
            dotSize: 2,
            boxFit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
