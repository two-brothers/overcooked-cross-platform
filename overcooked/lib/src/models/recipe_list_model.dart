import 'recipe_model.dart';

class RecipeListModel {
    final List<RecipeModel> recipes;

    RecipeListModel({ this.recipes });

    factory RecipeListModel.fromJson(Map<String, dynamic> json) {
        var list = json['data']['recipes'] as List;
        return RecipeListModel(
            recipes: list.map((i) => RecipeModel.fromJson(i)).toList()
        );
    }
}