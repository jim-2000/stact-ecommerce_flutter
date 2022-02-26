import 'package:flutter/material.dart';

class Mycircle extends StatelessWidget {
  bool isAsset;
  String img;
  Mycircle({
    Key? key,
    required this.isAsset,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: isAsset
            ? CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(img),
              )
            : CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(img),
              ),
      ),
    );
  }
}
