import 'package:http/http.dart' as http;
import '../models/recipe_list_model.dart';
import '../models/recipe_response_model.dart';
import 'dart:async';
import 'dart:convert';

class Api {
    static Future<RecipeListModel> getRecipeList(int index) async {
        final response = await http.get('https://overcooked.2brothers.tech/v1/recipes/at/$index');

        if (response.statusCode == 200) {
            return RecipeListModel.fromJson(json.decode(response.body));
        } else {
            throw Exception('Failed to load post');
        }
    }

    static Future<RecipeResponseModel> getRecipe(String id) async {
        final response = await http.get('https://overcooked.2brothers.tech/v1/recipes/$id');

        if (response.statusCode == 200) {
            return RecipeResponseModel.fromJson(json.decode(response.body));
        } else {
            throw Exception('Failed to load post');
        }
    }
}