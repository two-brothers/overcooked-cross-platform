import 'package:flutter/material.dart';
import '../models/recipe_response_model.dart';
import '../models/recipe_model.dart';
import '../services/api.dart';

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
                        final servesMakesHeading = recipe.serves != null && recipe.serves >= 0 ? "Serves" : "Makes";
                        final servesMakesValue = recipe.serves != null && recipe.serves >= 0 ? recipe.serves : recipe.makes;

                        return SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                    Image.network("https://overcooked.2brothers.tech/${recipe.imageUrl}"),
                                    Container(
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Text(
                                                        recipe.title.toUpperCase(),
                                                        textAlign: TextAlign.center,
                                                        style: new TextStyle(
                                                            fontSize: 20.0
                                                        )
                                                    ),
                                                ),
                                                Text("PREP"),
                                                Text(recipe.prepTime.toString()),
                                                Text("COOK"),
                                                Text(recipe.cookTime.toString()),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                        Container(
                                                            margin: EdgeInsets.only(right: 4),
                                                            child: Text(servesMakesHeading.toUpperCase()),
                                                        ),
                                                        Text(servesMakesValue.toString())
                                                    ],
                                                ),
                                                Text("INGREDIENTS", style: TextStyle(
                                                    fontSize: 16
                                                )),
                                                Divider(),
                                                ingredientSections(recipe.ingredientSections),
                                                Text("METHOD", style: TextStyle(
                                                    fontSize: 16
                                                )),
                                                Divider(),
                                                methodList(recipe.method)
                                            ]
                                        )
                                    )
                                ]
                            )
                        );

                    } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                }
            )
        );
    }
}

Widget ingredientSections(List<IngredientSection> ingredientSections) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: ingredientSections.map((section) => new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                if (section.heading != null) Text(section.heading, style: TextStyle(fontWeight: FontWeight.bold))
            ]
        )).toList(),
    );
}

Widget methodList(List<String> methodList) {
    return Column(
        children: methodList.asMap().map((i, item) => MapEntry(i, Container(
            margin: EdgeInsets.only(bottom: 16),
            child: (
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text((i + 1).toString()),
                        ),
                        Expanded(
                            child: Text(item)
                        )
                    ]
                )
            )
        ))).values.toList(),
    );
}