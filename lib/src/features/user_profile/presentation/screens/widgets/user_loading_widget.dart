import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/widgets/shimmer_widget.dart';

class UserLoadingWidget extends StatelessWidget {
  const UserLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: ShimmerWidget.rectangular(
        heigth: 16,
      ),
      /* subtitle: ShimmerWidget.rectangular(
        heigth: 14,
      ),*/
      leading: ShimmerWidget.circular(
        heigth: 64,
        width: 64,
      ),
    );
  }
}
