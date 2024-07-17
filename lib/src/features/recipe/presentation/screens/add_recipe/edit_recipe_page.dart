import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:your_recipes/providers.dart';
import 'package:your_recipes/src/common/utils/extensions.dart';
import 'package:your_recipes/src/features/recipe/domain/entities/recipe_entity.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/bloc/save_recipe_bloc.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/bloc/save_recipe_event.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/bloc/save_recipe_state.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/widgets/images_form_widget.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/widgets/ingredients_form_widget.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/widgets/steps_form_widget.dart';

class EditRecipePage extends StatefulWidget {
  final RecipeEntity recipeEntity;
  const EditRecipePage({
    super.key,
    required this.recipeEntity,
  });

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  late ScrollController scrollController;
  final _formKey = GlobalKey<FormState>();
  final _controller = getIt<SaveRecipeBloc>();

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return BlocProvider<SaveRecipeBloc>(
      create: (context) => _controller,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Criar Receita',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _controller.add(
                      SubmitSaveRecipeEvent(
                        recipeEntity: widget.recipeEntity,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Salvar',
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: BlocConsumer<SaveRecipeBloc, SaveRecipeState>(
              listener: (context, state) {
                if (state is SaveRecipeLoading) {
                  //todo: trocar essa aboradagem posteriormente
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is SaveRecipeError) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        state.customException!.customMessage!,
                      ),
                    ),
                  );
                }
                if (state is SaveRecipeSuccess) {
                  //fechar o dialog do loading
                  context.pop();
                  //ir para página anterior
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Receita criada com sucesso',
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  canPop: state is! SaveRecipeLoading,
                  key: _formKey,
                  child: Column(
                    children: [
                      ImagesFormWidget(
                        recipeEntity: widget.recipeEntity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              initialValue: widget.recipeEntity.name,
                              decoration: const InputDecoration(
                                hintText: 'Nome da receita',
                                // border: InputBorder.none,
                              ),
                              style: textTheme.titleLarge!.copyWith(
                                color: colors.primaryContainer,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: null,
                              onSaved: (value) =>
                                  widget.recipeEntity.name = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Campo obrigatório";
                                }
                                if (value.length < 6) {
                                  return "Nome muito curto";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: widget.recipeEntity.description,
                              decoration: const InputDecoration(
                                hintText:
                                    'Descrição: o que faz essa receita ser especial',
                                //border: InputBorder.none,
                              ),
                              style: textTheme.titleMedium,
                              maxLines: null,
                              onSaved: (value) =>
                                  widget.recipeEntity.description = value,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Tempo de preparo',
                                    style: textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    initialValue:
                                        widget.recipeEntity.preparationTime,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: const InputDecoration(
                                      hintText: '02:10',
                                    ),
                                    onSaved: (value) => widget
                                        .recipeEntity.preparationTime = value,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      MaskTextInputFormatter(
                                        mask: '##:##',
                                        filter: {
                                          "#": RegExp(
                                            r'[0-9]',
                                          ),
                                        },
                                        type: MaskAutoCompletionType.lazy,
                                      ),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      if (!RegExp(r'^\d{2}:\d{2}$')
                                          .hasMatch(value)) {
                                        return 'Formato inválido. Use dois dígitos para horas e minutos';
                                      }
                                      final parts = value.split(':');
                                      final minutes = int.parse(parts[1]);
                                      if (minutes >= 60) {
                                        return 'Minutos inválidos';
                                      }
                                      return null;
                                    },
                                    style: textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Porções',
                                    style: textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: widget.recipeEntity.portions,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: const InputDecoration(
                                      hintText: '10 pessoas',
                                    ),
                                    onSaved: (value) =>
                                        widget.recipeEntity.portions = value,
                                    style: textTheme.titleMedium,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      final parts = value.split(' ');
                                      if (parts.length < 2) {
                                        return 'Formato incorreto';
                                      }
                                      if (int.tryParse(parts.first) == null) {
                                        return 'Coloque a quantidade';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: IngredientsFormWidget(
                          listIngredients: widget.recipeEntity.baseIngredients,
                          pageListScrollController: scrollController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: StepsFormWidget(
                          listSteps: widget.recipeEntity.baseSteps,
                          pageListScrollController: scrollController,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
