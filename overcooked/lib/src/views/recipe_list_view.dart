import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/recipe_list_model.dart';
import '../models/recipe_model.dart';
import '../services/api.dart';
import 'recipe_view.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';

class RecipeList extends StatefulWidget {
    @override
    _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
    final _scrollController = ScrollController();
    final _scrollThreshold = 200.0;
    PostBloc _postBloc;

    @override
    void initState() {
        super.initState();
        _scrollController.addListener(_onScroll);
        _postBloc = BlocProvider.of<PostBloc>(context);
    }

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? BottomLoader()
                    : PostWidget(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
        /* return FutureBuilder<RecipeListModel>(
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
        );*/
    }

    @override
    void dispose() {
        _scrollController.dispose();
        super.dispose();
    }

    void _onScroll() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (maxScroll - currentScroll <= _scrollThreshold) {
            _postBloc.dispatch(Fetch());
        }
    }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final RecipeModel post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: Text(post.title),
    );
  }
}