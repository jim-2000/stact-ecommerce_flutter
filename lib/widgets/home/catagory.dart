import 'package:stack/screens/catagory_feed.dart';
import 'package:flutter/material.dart';

class HomeCatagory extends StatelessWidget {
  final String catName;
  final String catimg;
  HomeCatagory({Key? key, required this.catName, required this.catimg})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Catagory_feed.routeName,
          arguments: catName,
        );
        print("${catName}");
      },
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  catimg.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                catName.toString(),
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
