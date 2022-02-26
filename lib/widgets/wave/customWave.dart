import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Customwave extends StatelessWidget {
  Customwave({Key? key}) : super(key: key);
// ignore: non_constant_identifier_names
  List<int> _durations = [
    35000,
    11000,
    6000,
  ];
  List<double> _height = [0.01, 0.02, 0.03];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WaveWidget(
        config: CustomConfig(
          colors: [
            Colors.orangeAccent,
            Colors.pinkAccent,
            Colors.deepPurpleAccent,
          ],
          durations: _durations,
          heightPercentages: _height,
          blur: const MaskFilter.blur(BlurStyle.solid, 0),
        ),
        size: const Size(double.infinity, double.infinity),
      ),
    );
  }
}
