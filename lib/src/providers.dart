import 'package:provider/provider.dart';
import 'package:your_recipes/locator.dart';
import 'package:your_recipes/src/viewmodels/user_view_model.dart';

final userController = UserViewModel(locator());

final providers = [
  ChangeNotifierProvider<UserViewModel>.value(
    value: userController,
  ),
];
