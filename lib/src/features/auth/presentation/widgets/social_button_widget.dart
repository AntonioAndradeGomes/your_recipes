import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialMediaType {
  google('Entrar com Google'),
  apple('Entre com Apple');

  final String label;

  const SocialMediaType(
    this.label,
  );
}

class SocialButtonWidget extends StatelessWidget {
  final SocialMediaType type;
  final VoidCallback? onPressed;

  const SocialButtonWidget({
    super.key,
    required this.type,
    this.onPressed,
  });

  IconData get _icon {
    switch (type) {
      case SocialMediaType.google:
        return FontAwesomeIcons.google;
      case SocialMediaType.apple:
        return FontAwesomeIcons.apple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 50,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(_icon),
        label: Text(
          type.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        style: TextButton.styleFrom(
          elevation: 0,
          iconColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
