import 'recipe_model.dart';

class RecipeResponseModel {
    final Data data;

    RecipeResponseModel({ this.data });

    factory RecipeResponseModel.fromJson(Map<String, dynamic> json) {
        return RecipeResponseModel(
            data: Data.fromJson(json['data'])
        );
    }
}

class Data {
    final RecipeModel recipe;

    Data({ this.recipe });

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            recipe: RecipeModel.fromJson(json['recipe'])
        );
    }
}