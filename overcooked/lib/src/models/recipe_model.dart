import '../lookups/lookupIngredientType.dart';

class RecipeModel {
    final String id;
    final String title;
    final String imageUrl;
    final int serves;
    final int makes;
    final int prepTime;
    final int cookTime;
    final List<String> method;
    final List<IngredientSection> ingredientSections;

    RecipeModel({
        this.id,
        this.title,
        this.imageUrl,
        this.serves,
        this.makes,
        this.prepTime,
        this.cookTime,
        this.method,
        this.ingredientSections
    });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        return RecipeModel(
            id: json['id'],
            title: json['title'],
            imageUrl: json['imageUrl'],
            serves: json['serves'],
            makes: json['makes'],
            prepTime: json['prepTime'],
            cookTime: json['cookTime'],
            method: json['method'].cast<String>(),
            ingredientSections: (json['ingredientSections'] as List).map((i) => IngredientSection.fromJson(i)).toList()
        );
    }
}

class IngredientSection {
    final String heading;
    final List<dynamic> ingredients;

    IngredientSection({
        this.heading,
        this.ingredients
    });

    factory IngredientSection.fromJson(Map<String, dynamic> json) {
        return IngredientSection(
            heading: json['heading'],
            ingredients: (json['ingredients'] as List).map((i) => Ingredient.fromJson(i)).toList()
        );
    }
}

class Ingredient {
    final int ingredientType;

    Ingredient({
        this.ingredientType
    });

    factory Ingredient.fromJson(Map<String, dynamic> json) {
        if (json['ingredientType'] == LookupIngredientType.QUANTIFIED.id) {
            return Quantified.fromJson(json);
        }
        return FreeText.fromJson(json);
    }
}

class Quantified extends Ingredient {
    final int ingredientType;
    final double amount;

    Quantified({
        this.ingredientType,
        this.amount
    });

    factory Quantified.fromJson(Map<String, dynamic> json) {
        return Quantified(
            ingredientType: json['ingredientType'],
            amount: json['amount'].toDouble()
        );
    }
}

class FreeText extends Ingredient {
    final int ingredientType;
    final String description;

    FreeText({
        this.ingredientType,
        this.description
    });

    factory FreeText.fromJson(Map<String, dynamic> json) {
        return FreeText(
            ingredientType: json['ingredientType'],
            description: json['description']
        );
    }
}