import 'package:flutter/material.dart';
import '../models/recipe_response_model.dart';
import '../lookups/lookupIngredientType.dart';
import '../lookups/lookupIngredientUnitType.dart';
import '../models/recipe_model.dart';
import '../services/api.dart';
import '../utils/utils.dart';

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
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 24),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                            Container(
                                                                margin: EdgeInsets.only(right: 4),
                                                                child: Text(servesMakesHeading.toUpperCase()),
                                                            ),
                                                            Text(servesMakesValue.toString())
                                                        ],
                                                    ),
                                                ),
                                                Text("INGREDIENTS", style: TextStyle(
                                                    fontSize: 16
                                                )),
                                                Divider(),
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 16),
                                                    child: ingredientSections(recipe.ingredientSections, food),
                                                ),
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
                if (section.heading != null) Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(section.heading, style: TextStyle(fontWeight: FontWeight.bold))
                ),
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

Widget quantified(Quantified item, Map<String, Food> foodMap) {
    final defaultQuantity = 6;
    final activeQuantity = 6;

    final food = foodMap[item.foodId];

    var isFirstUnit = true;
    final units = item.unitIds.fold("", (acc, element) {
        final foodConversion = food.conversions.firstWhere((conversion) => conversion.unitId == element, orElse: () => null);

        if (foodConversion == null) {
            return "";
        }

        final amount = item.unitIds.length > 1 ? item.amount * foodConversion.ratio : item.amount;

        final foodQuantity = foodConversion.unitId == LookupIngredientUnitType.GRAMS.id ||
            foodConversion.unitId == LookupIngredientUnitType.MILLILITERS.id ? (amount / defaultQuantity * activeQuantity).ceil() :
            amount / defaultQuantity * activeQuantity;

        final displayAmount = (() {
            if (foodQuantity >= 1000 && foodConversion.unitId == LookupIngredientUnitType.GRAMS.id ||
                foodQuantity >= 1000 && foodConversion.unitId == LookupIngredientUnitType.MILLILITERS.id) {
                return (foodQuantity / 1000).toStringAsFixed(2);
            }
            return toPrettyStringFraction(foodQuantity.toDouble());
        })();

        final ingredientUnitType = (() {
            if (foodQuantity >= 1000 && foodConversion.unitId == LookupIngredientUnitType.GRAMS.id) {
                return LookupIngredientUnitType.KILOGRAMS;
            }
            if (foodQuantity >= 1000 && foodConversion.unitId == LookupIngredientUnitType.MILLILITERS.id) {
                return LookupIngredientUnitType.LITERS;
            }
            return LookupIngredientUnitType.dataLookup(foodConversion.unitId);
        })();

        final String unit = foodQuantity > 1 ? ingredientUnitType.plural : ingredientUnitType.singular;

        if (isFirstUnit) {
            isFirstUnit = false;
            return "$acc$displayAmount$unit";
        }

        return "$acc($displayAmount${unit.trimRight()}) ";
    });

    final foodName = () {
        final int lastUnitId = food.conversions.last.unitId;
        if (lastUnitId == LookupIngredientUnitType.SLICE.id ||
            lastUnitId == LookupIngredientUnitType.SINGULAR.id && item.amount / defaultQuantity * activeQuantity <= 1) {
            return food.name.singular;
        }
        return food.name.plural;
    }();

    final additionalDesc = item.additionalDesc != null ? ", ${item.additionalDesc}" : null;

    final description = "$units$foodName";

    return Padding(
        padding: EdgeInsets.only(top: 2, bottom: 2),
        child: Row(
            children: <Widget>[
                Text(description),
                if (additionalDesc != null) Text(additionalDesc, style: TextStyle(fontStyle: FontStyle.italic)),
            ],
        ),
    );
}

Widget freeText(FreeText freeText) {
    return Padding(
        padding: EdgeInsets.only(top: 2, bottom: 2),
        child: Text(freeText.description)
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