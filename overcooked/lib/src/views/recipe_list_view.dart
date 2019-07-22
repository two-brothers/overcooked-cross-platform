import 'package:flutter/material.dart';
import '../models/recipe_list_model.dart';
import '../services/api.dart';
import 'recipe_view.dart';

class RecipeList extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return FutureBuilder<RecipeListModel>(
            future: Api.getRecipeList(),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.recipes.length,
                        itemBuilder: (context, i) {
                            final recipe = snapshot.data.recipes[i];
                            return ListTile(
                                onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RecipeView(id: recipe.id)),
                                    );
                                },
                                title: Text(snapshot.data.recipes[i].title)
                            );
                        }
                    );
                } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
            }
        );
    }
}