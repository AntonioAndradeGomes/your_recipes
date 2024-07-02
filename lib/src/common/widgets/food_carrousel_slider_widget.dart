import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class FoodCarrouselSliderWidget extends StatelessWidget {
  final List<Widget> items;
  const FoodCarrouselSliderWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: AnotherCarousel(
        autoplay: false,
        dotColor: Colors.white,
        dotBgColor: Colors.transparent,
        dotSize: 5,
        dotSpacing: 15,
        images: items,
      ),
    );
  }
}
