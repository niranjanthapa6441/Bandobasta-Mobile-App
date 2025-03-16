import 'package:flutter/material.dart';

class SlideIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalImages;

  const SlideIndicator({
    super.key,
    required this.currentIndex,
    required this.totalImages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalImages, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.teal : Colors.grey,
          ),
        );
      }),
    );
  }
}
