import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';

class UserProfileImageWidget extends StatelessWidget {
  final double size;
  final String name;
  final dynamic image;
  const UserProfileImageWidget({
    super.key,
    required this.size,
    required this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          color: colors.primary,
          child: image == null
              ? Center(
                  child: Text(
                    name.isNotEmpty ? name.split(' ').first[0] : '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) {
                    return Center(
                      child: Text(
                        name.isNotEmpty ? name.split(' ').first[0] : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
