import 'package:flutter/material.dart';

class Space extends StatelessWidget {
 final double width;
 final double height;
  const Space({Key? key, required  this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
      );
    }
}
