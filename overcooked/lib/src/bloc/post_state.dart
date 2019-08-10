import 'package:equatable/equatable.dart';
import '../models/recipe_model.dart';

abstract class PostState extends Equatable {
    PostState([List props = const []]) : super(props);
}

class PostUninitialized extends PostState {}

class PostError extends PostState {}

class PostLoaded extends PostState {
    final List<RecipeModel> posts;
    final bool hasReachedMax;
    final int currentIndex;

    PostLoaded({
        this.posts,
        this.hasReachedMax,
        this.currentIndex,
    }) : super([posts, hasReachedMax]);
}