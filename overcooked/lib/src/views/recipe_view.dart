import 'package:flutter/material.dart';
import '../models/recipe_response_model.dart';
import '../lookups/lookupIngredientType.dart';
import '../models/recipe_model.dart';
import '../services/api.dart';

class RecipeView extends StatelessWidget {

    final String id;

    const RecipeView({ Key key, @required this.id }) : super(key: key);

    getFormattedRecipeTime(int totalTime) {
        if (totalTime <= 0) {
            return "NONE";
        }

        final int hours = totalTime.floor() ~/ 60;
        final int mins = totalTime % 60;

        final hourString = hours > 0 ? "${hours}H" : "";
        final minString = mins > 0 ? "${mins}M" : "";

        return hours > 0 ? "$hourString $minString" : minString;
    }

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
                        final food = snapshot.data.data.food;
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
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                        Container(
                                                            margin: EdgeInsets.only(right: 4),
                                                            child: Text("PREP"),
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets.only(right: 4),
                                                            child: Text(getFormattedRecipeTime(recipe.prepTime)),
                                                        ),
                                                        Text(" - "),
                                                        Container(
                                                            margin: EdgeInsets.only(right: 4),
                                                            child: Text("COOK"),
                                                        ),
                                                        Text(getFormattedRecipeTime(recipe.cookTime)),
                                                    ]
                                                ),
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
                                                ingredientSections(recipe.ingredientSections, food),
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

Widget ingredientSections(List<IngredientSection> ingredientSections, Map<String, Food> food) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: ingredientSections.map((section) => new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                if (section.heading != null) Text(section.heading, style: TextStyle(fontWeight: FontWeight.bold)),
                ingredientList(section.ingredients, food)
            ]
        )).toList(),
    );
}

Widget ingredientList(List<Ingredient> ingredients, Map<String, Food> food) {
    return Column(
        children: ingredients.map((ingredient) => new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                if (ingredient.ingredientType == LookupIngredientType.QUANTIFIED.id) quantified(ingredient, food) else freeText(ingredient)
            ]
        )).toList(),
    );
}

Widget quantified(Quantified quantified, Map<String, Food> foodMap) {
    final food = foodMap[quantified.foodId];
    return Text("quantified: ${food.id}");
}

Widget freeText(FreeText freeText) {
    return Text(freeText.description);
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