import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipes/src/features/recipe/domain/usecase/save_recipe_usecase.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/bloc/save_recipe_event.dart';
import 'package:your_recipes/src/features/recipe/presentation/screens/add_recipe/bloc/save_recipe_state.dart';

class SaveRecipeBloc extends Bloc<SaveRecipeEvent, SaveRecipeState> {
  final SaveRecipeUseCase _saveRecipeUseCase;
  SaveRecipeBloc({
    required SaveRecipeUseCase saveRecipeUseCase,
  })  : _saveRecipeUseCase = saveRecipeUseCase,
        super(SaveRecipeInitial()) {
    on<SubmitSaveRecipeEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitSaveRecipeEvent event,
    Emitter<SaveRecipeState> emit,
  ) async {
    emit(SaveRecipeLoading());
    final result = await _saveRecipeUseCase.call(event.recipeEntity);
    result.fold(
      (success) => emit(SaveRecipeSuccess(success)),
      (failure) => emit(SaveRecipeError(failure)),
    );
  }
}
