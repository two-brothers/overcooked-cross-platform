import 'package:http/http.dart' as http;
import '../models/recipe_list_model.dart';
import 'dart:async';
import 'dart:convert';

class Api {
    static Future<RecipeListModel> getRecipeList() async {
        final response = await http.get('https://overcooked.2brothers.tech/v1/recipes/at/0');

        if (response.statusCode == 200) {
            return RecipeListModel.fromJson(json.decode(response.body));
        } else {
            throw Exception('Failed to load post');
        }
    }
}