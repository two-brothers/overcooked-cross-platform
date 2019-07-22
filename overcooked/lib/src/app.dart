import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './models/recipe_list_model.dart';
import './models/recipe_model.dart';
import 'dart:async';
import 'dart:convert';

Future<RecipeListModel> fetchRecipes() async {
    final response = await http.get('https://overcooked.2brothers.tech/v1/recipes/at/0');

    if (response.statusCode == 200) {
        return RecipeListModel.fromJson(json.decode(response.body));
    } else {
        throw Exception('Failed to load post');
    }
}

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
            future: fetchRecipes(),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.recipes.length,
                        itemBuilder: (context, i) {
                            return ListTile(
                                onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RecipeView(recipeModel: snapshot.data.recipes[i])),
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

    final RecipeModel recipeModel;

    const RecipeView({ Key key, @required this.recipeModel }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(recipeModel.title),
            ),
            body: Center(
                child: RaisedButton(
                    onPressed: () {
                        Navigator.pop(context);
                    },
                    child: Text('Go back!'),
                ),
            ),
        );
    }
}