import 'package:flutter/material.dart';
import 'package:your_recipes/src/config/extensions.dart';

class LoginTextFormFieldPasswordWidget extends StatefulWidget {
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;

  const LoginTextFormFieldPasswordWidget({
    Key? key,
    this.textEditingController,
    this.validator,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  State<LoginTextFormFieldPasswordWidget> createState() =>
      _LoginTextFormFieldPasswordWidgetState();
}

class _LoginTextFormFieldPasswordWidgetState
    extends State<LoginTextFormFieldPasswordWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return TextFormField(
      validator: widget.validator,
      controller: widget.textEditingController,
      keyboardType: TextInputType.text,
      obscureText: isObscure,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        isDense: true,
        labelText: 'Senha',
        suffixIconColor: colors.primary,
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        ),
      ),
    );
  }
}
