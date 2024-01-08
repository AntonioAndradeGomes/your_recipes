import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_recipes/common/theme/dimensions.dart';
import 'package:your_recipes/common/utils/extensions.dart';
import 'package:your_recipes/features/auth/presentation/cubit/login_cubit.dart';
import 'package:your_recipes/features/auth/presentation/cubit/login_state.dart';
import 'package:your_recipes/features/auth/presentation/widgets/social_button_widget.dart';
import 'package:your_recipes/providers.dart';
import '../widgets/login_text_form_field_password_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _controller = getIt.get<LoginCubit>();
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: Dimensions.paddingAllMedium,
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(
                      milliseconds: 1000,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.bowlFood,
                          color: colors.primary,
                          size: Dimensions.iconSizeLarger,
                        ),
                        Dimensions.verticalSpaceSmaller,
                        Text(
                          "Suas Receitas",
                          style: GoogleFonts.anton(
                            color: colors.primary,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Dimensions.verticalSpaceMedium,
                  FadeInUp(
                    duration: const Duration(
                      milliseconds: 1400,
                    ),
                    child: BlocBuilder<LoginCubit, LoginState>(
                      bloc: _controller,
                      builder: (context, state) {
                        print(state);
                        if (state is LoadingLoginState) {
                          return const CircularProgressIndicator();
                        }
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SocialButtonWidget(
                                type: SocialMediaType.google,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  _controller.singInWithGoogle();
                                },
                              ),
                              Dimensions.verticalSpaceMedium,
                              SocialButtonWidget(
                                type: SocialMediaType.apple,
                                onPressed: () {},
                              ),
                              Dimensions.verticalSpaceMedium,
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: TextFormField(
                                  controller: _emailEC,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Preencha o email";
                                    }
                                    final emailRegex = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Por favor, insira um email válido';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              Dimensions.verticalSpaceMedium,
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: LoginTextFormFieldPasswordWidget(
                                  textEditingController: _passwordEC,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Preencha a senha";
                                    }
                                    if (value.length <= 6) {
                                      return "Senha inválida";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Dimensions.verticalSpaceSmallest,
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Esqueceu sua senha?',
                                    ),
                                  ),
                                ),
                              ),
                              Dimensions.verticalSpaceMedium,
                              SizedBox(
                                width: 400,
                                height: 50,
                                child: FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      print("validado");
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    elevation: 0,
                                    iconColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Dimensions.verticalSpaceMedium,
                              SizedBox(
                                width: 400,
                                height: 50,
                                child: FilledButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    elevation: 0,
                                    iconColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cadastre-se',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
