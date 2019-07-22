class RecipeModel {
    final List<Recipe> recipes;

    RecipeModel({ this.recipes });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        var list = json['data']['recipes'] as List;
        return RecipeModel(
            recipes: list.map((i) => Recipe.fromJson(i)).toList()
        );
    }
}

class Recipe {
    final String title;

    Recipe({ this.title });

    factory Recipe.fromJson(Map<String, dynamic> json) {
        return Recipe(
            title: json['title']
        );
    }
}