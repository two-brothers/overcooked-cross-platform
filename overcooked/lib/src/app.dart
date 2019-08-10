import 'package:flutter/material.dart';
import './views/recipe_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/post_bloc.dart';
import 'package:http/http.dart' as http;
import './bloc/post_event.dart';

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
                // body: RecipeList(),
                body: BlocProvider(
                    builder: (context) => PostBloc(httpClient: http.Client())..dispatch(Fetch()),
                    child: RecipeList(),
                )
            ),
        );
    }
}
