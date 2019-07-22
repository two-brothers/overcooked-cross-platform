import 'package:flutter/material.dart';
import './models/recipe_list_model.dart';
import './models/recipe_response_model.dart';
import './services/api.dart';

class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Overcooked',
            home: Scaffold(
                appBar: AppBar(
                    title: Text('Overcooked'),
                ),
                body: RecipeList(),
            ),
        );
    }
}

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
                            final recipe = snapshot.data.recipes[i]
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

class RecipeView extends StatelessWidget {

    final String id;

    const RecipeView({ Key key, @required this.id }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("recipe"),
            ),
            body: FutureBuilder<RecipeResponseModel>(
                future: Api.getRecipe(id),
                builder: (context, snapshot) {
                    if (snapshot.hasData) {
                        final recipe = snapshot.data.data.recipe;
                        return Text(recipe.title);
                    } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                }
            )
        );
    }
}