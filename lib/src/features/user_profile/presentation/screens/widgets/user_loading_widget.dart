import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/theme/dimensions.dart';
import 'package:your_recipes/src/common/widgets/shimmer_widget.dart';

class UserLoadingWidget extends StatelessWidget {
  const UserLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          const ShimmerWidget.circular(
            heigth: 75,
            width: 75,
          ),
          Dimensions.verticalSpaceSmaller,
          const ShimmerWidget.rectangular(
            heigth: 14,
          ),
          Dimensions.verticalSpaceSmallest,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: ShimmerWidget.rectangular(
              heigth: 10,
            ),
          ),
          Dimensions.verticalSpaceSmallest,
        ],
      ),
    );
  }
}
