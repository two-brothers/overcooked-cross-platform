import 'recipe_model.dart';
import 'package:equatable/equatable.dart';

class RecipeListModel extends Equatable {
    final List<RecipeModel> recipes;
    final bool lastPage;

    RecipeListModel({
        this.recipes,
        this.lastPage
    });

    factory RecipeListModel.fromJson(Map<String, dynamic> json) {
        var list = json['data']['recipes'] as List;
        return RecipeListModel(
            recipes: list.map((i) => RecipeModel.fromJson(i)).toList(),
            lastPage: json['data']['lastPage']
        );
    }
}