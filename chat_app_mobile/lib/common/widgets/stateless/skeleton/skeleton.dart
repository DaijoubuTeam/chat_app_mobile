import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton.rectangular({
    super.key,
    this.height = 10,
    this.width = 10,
    this.shapeBorder,
  });

  const Skeleton.circle(
      {super.key,
      this.height = 10,
      this.width = 10,
      this.shapeBorder = const CircleBorder()});

  final double height;
  final double width;
  final ShapeBorder? shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8.0),
        decoration: ShapeDecoration(
          shape: shapeBorder ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
          color: Colors.grey[400]!,
        ),
      ),
    );
  }
}
