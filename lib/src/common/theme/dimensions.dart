import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Dimensions {
  static final paddingAllLargest = const EdgeInsets.all(50).w;
  static final paddingAllLarger = const EdgeInsets.all(30).w;
  static final paddingAllLarge = const EdgeInsets.all(20).w;
  static final paddingAllMedium = const EdgeInsets.all(10).w;
  static final paddingAllSmall = const EdgeInsets.all(8).w;

  static final bottomNavBarMargin = const EdgeInsets.symmetric(
    horizontal: 50,
    vertical: 20,
  ).w;

  static final paddingHorizontalLarge = const EdgeInsets.symmetric(
    horizontal: 20,
  ).w;

  static final paddingHorizontalMedium = const EdgeInsets.symmetric(
    horizontal: 16.0,
  ).w;

  static final paddingHorizontalSmall = const EdgeInsets.symmetric(
    horizontal: 10.0,
  ).w;

  static final paddingVerticalLarge = const EdgeInsets.symmetric(
    vertical: 20.0,
  ).w;

  //BorderRadius
  static final borderRadiusAllLarger = BorderRadius.circular(50).w;
  static final kBorderRadiusAllLarge = BorderRadius.circular(30).w;
  static final kBorderRadiusAllMedium = BorderRadius.circular(20).w;
  static final kBorderRadiusAllSmall = BorderRadius.circular(16).w;
  static final kBorderRadiusAllSmallest = BorderRadius.circular(6).w;
  static final kRadiusAllSmallest = const Radius.circular(6).w;

  //VerticalSpace
  static final verticalSpaceLargest = SizedBox(height: 100.h);
  static final verticalSpaceLarger = SizedBox(height: 50.h);
  static final verticalSpaceLarge = SizedBox(height: 30.h);
  static final verticalSpaceMedium = SizedBox(height: 20.h);
  static final verticalSpaceSmall = SizedBox(height: 16.h);
  static final verticalSpaceSmaller = SizedBox(height: 10.h);
  static final verticalSpaceSmallest = SizedBox(height: 8.h);

  //Horizontal Space
  static final horizontalSpaceLargest = SizedBox(width: 30.w);
  static final horizontalSpaceLarger = SizedBox(width: 24.w);
  static final horizontalSpaceLarge = SizedBox(width: 20.w);
  static final horizontalSpaceMedium = SizedBox(width: 16.w);
  static final horizontalSpaceSmall = SizedBox(width: 10.w);
  static final horizontalSpaceSmaller = SizedBox(width: 8.w);

  // Size
  static final double iconSizeLargest = 80.h;
  static final double iconSizeLarger = 48.h;
  static final double iconSizeLarge = 36.h;
  static final double iconSizeMedium = 30.h;
  static final double iconSizeSmall = 24.h;
  static final double iconSizeSmallest = 16.h;

  static final double sizeLargest = 40.h;
  static final double sizeLarger = 20.h;
  static final double sizeLarge = 18.h;
  static final double sizeMedium = 16.h;
  static final double sizeSmall = 12.h;
  static final double sizeSmaller = 8.h;
  static final double sizeSmallest = 6.h;
}
