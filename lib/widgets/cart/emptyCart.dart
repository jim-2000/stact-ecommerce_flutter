import 'package:stack/screens/homeScreen.dart';
import 'package:stack/styles/themes/appTexttheme.dart';
import 'package:stack/styles/themes/myApptheme.dart';
import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  String imgss;
  String title;
  String? subtitle;
  VoidCallback? onButtonTap;
  EmptyCard({
    Key? key,
    required this.imgss,
    required this.title,
    this.subtitle,
    this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imgss.toString()),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 100,
            width: 250,
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  subtitle.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 55),
              ),
              onPressed: onButtonTap ?? () {},
              child: Text(
                "Shop Now".toUpperCase(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
