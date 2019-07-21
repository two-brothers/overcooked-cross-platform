import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Data> fetchRecipes() async {
    final response = await http.get('https://overcooked.2brothers.tech/v1/recipes/at/0');

    if (response.statusCode == 200) {
        return Data.fromJson(json.decode(response.body));
    } else {
        throw Exception('Failed to load post');
    }
}

class Data {
    final List<Recipe> recipes;

    Data({ this.recipes });

    factory Data.fromJson(Map<String, dynamic> json) {
        var list = json['data']['recipes'] as List;
        return Data(
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

void main() => runApp(App());

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

class RecipeListState extends State<RecipeList> {
    @override
    Widget build(BuildContext context) {
        return FutureBuilder<Data>(
            future: fetchRecipes(),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.recipes.length,
                        itemBuilder: (context, i) {
                            return ListTile(
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

class RecipeList extends StatefulWidget {
    @override
    RecipeListState createState() => RecipeListState();
}