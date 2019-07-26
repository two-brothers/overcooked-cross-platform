import 'package:flutter/material.dart';
import './views/recipe_list_view.dart';

class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Overcooked',
            theme: ThemeData(
                fontFamily: 'Lato',
            ),
            home: Scaffold(
                appBar: AppBar(
                    title: Text('Overcooked'),
                ),
                body: RecipeList(),
            ),
        );
    }
}
