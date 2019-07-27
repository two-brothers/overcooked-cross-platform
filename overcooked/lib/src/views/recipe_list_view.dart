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
                                    child: Stack(
                                        children: <Widget>[
                                            Image.network("https://overcooked.2brothers.tech/${recipe.imageUrl}"),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                width: MediaQuery.of(context).size.width,
                                                height: 80,
                                                child: (
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment.bottomCenter,
                                                                end: Alignment.topCenter,
                                                                colors: [Colors.black87, Colors.transparent]
                                                            )
                                                        ),
                                                        child: Padding(
                                                            padding: EdgeInsets.all(100),
                                                        )
                                                    )
                                                )
                                            ),
                                            Positioned(
                                                bottom: 16,
                                                left: 16,
                                                width: MediaQuery.of(context).size.width,
                                                child: (
                                                    Text(
                                                        recipe.title.toUpperCase(),
                                                        style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Color(0xFFFFFFFF)
                                                        ),
                                                    )
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