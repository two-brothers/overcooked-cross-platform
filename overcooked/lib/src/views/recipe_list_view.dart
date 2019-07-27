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
                        padding: EdgeInsets.all(4),
                        itemBuilder: (context, i) {
                            final recipe = snapshot.data.recipes[i];
                            return GestureDetector(
                                onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RecipeView(id: recipe.id)),
                                    );
                                },
                                child: new Card(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                            Image.network("https://overcooked.2brothers.tech/${recipe.imageUrl}"),
                                            Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                    recipe.title,
                                                    style: new TextStyle(
                                                        fontSize: 16.0
                                                    ),
                                                )
                                            )
                                        ]
                                    )
                                )
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