import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final GestureTapCallback? onTap;
  final double? size;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.color,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              icon,
              color: onTap != null ? color : Colors.grey[400],
              size: size ?? 24,
            ),
          ),
        ),
      ),
    );
  }
}
