import 'package:flutter/material.dart';
import 'icon_botton_bar_widget.dart';

class CustomBottomAppBarWidget extends StatelessWidget {
  final TypeButton selectedButton;
  final ValueChanged<TypeButton> onChanged;
  final VoidCallback? onPressedAddRecipe;
  const CustomBottomAppBarWidget({
    super.key,
    required this.selectedButton,
    required this.onChanged,
    this.onPressedAddRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconBottonBarWidget(
              typeButton: TypeButton.home,
              typeSelected: selectedButton,
              onTap: () => onChanged(TypeButton.home),
            ),
            const SizedBox(
              width: 10,
            ),
            IconBottonBarWidget(
              typeButton: TypeButton.search,
              typeSelected: selectedButton,
              onTap: () => onChanged(TypeButton.search),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              onPressed: onPressedAddRecipe,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              tooltip: 'Adicionar uma receita',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconBottonBarWidget(
              typeButton: TypeButton.favorite,
              typeSelected: selectedButton,
              onTap: () => onChanged(TypeButton.favorite),
            ),
            const SizedBox(
              width: 10,
            ),
            IconBottonBarWidget(
              typeButton: TypeButton.person,
              typeSelected: selectedButton,
              onTap: () => onChanged(TypeButton.person),
            ),
          ],
        ),
      ),
    );
  }
}
