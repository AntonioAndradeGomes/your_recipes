import 'package:flutter/material.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

enum TypeButton {
  home(
    'Início',
    Icons.home_rounded,
    '/',
  ),
  search(
    'Buscar',
    Icons.search_rounded,
    '/search',
  ),
  favorite(
    'Favoritos',
    Icons.favorite,
    '/favorite',
  ),
  person(
    'Perfil',
    Icons.person_rounded,
    '/profile',
  );

  final String label;
  final String path;
  final IconData icon;
  const TypeButton(
    this.label,
    this.icon,
    this.path,
  );
}

class IconBottonBarWidget extends StatelessWidget {
  final TypeButton typeButton;
  final TypeButton typeSelected;
  final Function()? onTap;
  const IconBottonBarWidget({
    Key? key,
    required this.typeButton,
    this.onTap,
    required this.typeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colorScheme.primary;
    final isSelected = typeButton == typeSelected;
    return ZoomTapAnimation(
      onTap: onTap,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              typeButton.icon,
              size: 30,
              color: isSelected ? primaryColor : Colors.black54,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              typeButton.label,
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.black54,
                height: .1,
                fontSize: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}
