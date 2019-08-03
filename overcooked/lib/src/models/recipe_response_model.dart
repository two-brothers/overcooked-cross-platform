import 'recipe_model.dart';
import './food.dart';

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
    final Map<String, Food> food;

    Data({
        this.recipe,
        this.food
    });

    factory Data.fromJson(Map<String, dynamic> json) {
        Map<String, Food> foodMap = new Map();

        json['food'].forEach((k,v) {
            foodMap.addAll({ k: Food.fromJson(v)});
        });

        return Data(
            recipe: RecipeModel.fromJson(json['recipe']),
            food: foodMap
        );
    }
}